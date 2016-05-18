//
//  login.swift
//  
//
//  Created by Bobby Carver  on 01/03/2016.
//
//

import UIKit // import UIKIT
import CoreData // import CoreData

// my variables structure
struct MyVariables {
    static var trackuser = "" // track user throughout application
    static var fileopen = "" // file open
    static var useablefilename = "" // file name that can be used
    
}


class login: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // objects from controller
    @IBOutlet weak var InUsername: UITextField!
    @IBOutlet weak var InPassword: UITextField!
    @IBOutlet weak var LBLMessage: UILabel!
    

    @IBAction func loginAttempt(sender: AnyObject) { // button login function
        
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate) // app delegate
        var context:NSManagedObjectContext = appDel.managedObjectContext! // context of managedobject
        
        var request = NSFetchRequest(entityName: "Users") // request from NSFetchRequest on enity name Users
        request.returnsObjectsAsFaults = false // return objects as false set to false
        
        request.predicate = NSPredicate(format: "username = %@", InUsername.text) // predicate based on username entered
        
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)! // results of NSARRAY and of contexted executed request
        
        println(results.count) // print results for testing
        
        if (results.count > 0) { // if results is greater than 0 a record does exist
            //            for res in results{
            //                println(res)
            //            }
            var r = results[0] as! NSManagedObject //set R from array results and of NSMANAGED OBJECT
            
            println(r.valueForKey("username"))// print to log for testing
            println(r.valueForKey("password")) // print to log for testing
            
            var loadedusername = r.valueForKey("username") as! String // set loaded username from records as String object from key username
            var loadedpassword = r.valueForKey("password") as! String // set loaded password from records as string object from key password
            var loadedname = r.valueForKey("name") as! String // set loaded name from records as string object from key firstname
            
            var userstring = "\(loadedusername)"// turn string object to string
            var passwordstring = "\(loadedpassword)" // turn string object to string
            var name = "\(loadedname)" // turn screen object to string
            
            if( InUsername.text.isEmpty) || (InPassword.text.isEmpty) { // check if one or more fields are empty
                LBLMessage.text = "one or more fields empty" // print error
            }else{ // user has submitted correct fields
                
                if (userstring == InUsername.text) && (InPassword.text == passwordstring) { // check if entered username and password match those fetched from database
                    print("log in ") // print to log a sucessful log in for testing
                    
                    MyVariables.trackuser = userstring
                    println(MyVariables.trackuser)
                    
                    performSegueWithIdentifier("SeaugeLogin", sender: nil) // perform seague and switch views
                    
                    // unworking code commented out
                    
                    
                    
                }else{ // else records to not match
                    print("no sign in ") //print for testing
                    LBLMessage.text = "Username or password does not match "// print error to user
                }
                
            }
            
            print(loadedusername) // print for testing
            print(loadedpassword) // print for testing
            print(name)// print for testing
            print(InUsername.text)//print for testing
            print(InPassword.text)//print for testing
            
            
        }else{//else no records found
            
            println("Nothing returned") //print for testing
            
            LBLMessage.text  = "invalid log in try again"// print error to user
        }
        
        println("Load") // print for testing
        
    }
    
}


