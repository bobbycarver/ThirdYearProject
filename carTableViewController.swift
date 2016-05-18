//
//  carTableViewController.swift
//  
//
//  Created by Bobby Carver on 24/03/2016.
//
//

import UIKit //Import UIKit
import CoreData //Import CoreData


class carTableViewController: UITableViewController {
    
    var loadedcar = [mycar]() //loaded car array as mycar class

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadcars()

    }
    
    
    
    func loadcars() {
        
        
        var userID = MyVariables.trackuser // user id as tracked user
        
        println(userID) // print for testing
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate) // app delegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext! // context of managedobject
        
        var request = NSFetchRequest(entityName: "Users") // request from NSFetchRequest on enity name Users
        
        request.returnsObjectsAsFaults = false // return objects as false set to false
        
        request.predicate = NSPredicate(format: "username = %@", userID) // predicate based on username entered
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)! // results of NSARRAY and of contexted executed request
        
        println(results.count) // print results for testing
        
        if (results.count > 0) { // if results is greater than 0 a record does exist
            //            for res in results{
            //                println(res)
            //            }
            
            var r = results[0] as! NSManagedObject //set R from array results and of NSMANAGED OBJECT
            
            println(r.valueForKey("username"))// print to log for testing
            
            
            //load records
            var loadednumberplate = r.valueForKey("numberplate") as! String
            var loadedmake = r.valueForKey("make") as! String
            var loadedmodel = r.valueForKey("model") as! String
            
            
            //create objects as mycar class using the following values
            let car1 = mycar(heading: "Number Plate", info: loadednumberplate)!
            let car2 = mycar(heading: "Make", info: loadedmake)!
            let car3 = mycar(heading: "Model", info: loadedmodel)!
            
            loadedcar += [car1,car2,car3] // save objects to array
            
            
        }else{//else no records found
            
            println("Nothing returned") //print for testing
            
            
        }
        
        println("Load") // print for testing

        
    } // end function loaded car
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return loadedcar.count // number of objects in loaded car array
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "carcell" //cell identifier as carcell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! settingsTableViewCell // create cell from custom cell class and cell identifier
        
        let car = loadedcar[indexPath.row] // car as loadedcar at indexpath.row
        
        cell.carlbl.text = car.heading // cell label as object car heading
        
        cell.cartb.text = car.info // cell text as object car info
        
        return cell // return cell
        
    }
    
}// end class
