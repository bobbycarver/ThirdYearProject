//
//  myprofileTableViewController.swift
//  
//
//  Created by Bobby Carver on 23/03/2016.
//
//

import UIKit // import UIKit
import CoreData // import CoreData

class myprofileTableViewController: UITableViewController {
    
    
    var loadedprofile = [myprofile]() // loaded profile array of objects using myprofile class

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadprofile() // run loadprofile function

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadprofile() {
        
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
                var loadedname = r.valueForKey("name") as! String
                var loadedemail = r.valueForKey("email") as! String
                var loadedaddress = r.valueForKey("address") as! String
                var loadedcontact = r.valueForKey("contact") as! String
                var loadedpass = r.valueForKey("password") as! String
                var loadeddob = r.valueForKey("dob") as! NSDate
                                
                // create profile objects using information from coredata
                let profile1 = myprofile(heading: "name", info: loadedname)!
                let profile2 = myprofile(heading: "email", info: loadedemail)!
                let profile3 = myprofile(heading: "address", info: loadedaddress)!
                let profile4 = myprofile(heading: "contact", info: loadedcontact)!
                let profile5 = myprofile(heading: "dob", info: "\(loadeddob)")!
                let profile6 = myprofile(heading: "password", info: loadedpass)!
                let profile7 = myprofile(heading: "Confirm Password", info: "type password")!
                
                
                loadedprofile += [profile1,profile2,profile3,profile4,profile5,profile6,profile7] //save new objects to array
                
                
            }else{//else no records found
                
                println("Nothing returned") //print for testing
                
            } // end else
            
            println("Load") // print for testing
        
    } // end function load profile
    


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return loadedprofile.count // return item count for loaded profile
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "profilecell" // cell identifier as profilecell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! settingsTableViewCell // create sell from custom cell class and cell identifier
        
        let profile = loadedprofile[indexPath.row] // profile as loaded profile as indexpath.row
        
        cell.profilelbl.text = profile.heading // cell label as heading from object
        
        cell.profiletb.text = profile.info // cell text as info from object
        
        return cell // return cell
    }

} // end class
