//
//  Register.swift
//  
//
//  Created by Bobby Carver on 29/02/2016.
//
//

import UIKit    // Default UIKIT import
import CoreData // IMPORT CORE DATA

// variable structure for registering user
struct RegisterVariables {
    //car
    static var numberplate = ""
    static var make = ""
    static var model = ""
    //profile
    static var username = ""
    static var password = ""
    static var email = ""
    //person
    static var name = ""
    static var contact = ""
    static var address = ""
    static var dob = NSDate()
    
    
    
}

class Register: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      // objects
    @IBOutlet weak var numplate: UITextField!
    @IBOutlet weak var outputMake: UILabel!
    @IBOutlet weak var outputModel: UILabel!
    @IBOutlet weak var outputError: UILabel!
    @IBOutlet weak var outFullName: UITextField!
    @IBOutlet weak var outDob: UIDatePicker!
    @IBOutlet weak var OutAddress: UITextField!
    @IBOutlet weak var OutContact: UITextField!
    @IBOutlet weak var error2: UILabel!
    @IBOutlet weak var outUsername: UITextField!
    @IBOutlet weak var outEmail: UITextField!
    @IBOutlet weak var OutPassword: UITextField!
    @IBOutlet weak var OutputPasswordConfirm: UITextField!
    @IBOutlet weak var error3: UILabel!
    
    
    


    @IBAction func btnGo(sender: AnyObject) {
        
        
        
          var numberplate = numplate.text // get numberplate from text field
        
        if numberplate.isEmpty { // check if numberplate empty
            
            //ERROR no number plate
            
            outputError.text = "error no numberplate entered"
            
            println("no plate") // print for testing 
            
        } else {
            println("plate") // print for testing
            RegisterVariables.numberplate = numberplate // set numberplate in structured variables
            FetchMake() // run fetch make function
            FetchModel() // run fetch model function
            
            
        }// end of else on if empty
    
    
    }// end of button function
    
    func FetchMake() {
        
        // NSURL using RAC website and users numberplate to perform screenscrape
        var newURL = NSURL(string: "https://www.rac.co.uk/buying-a-car/car-passport/report/buyer/purchase/?BuyerVrm=\(numplate.text)")
        var htmlData: NSData = NSData(contentsOfURL: newURL!)! // create data of NSData using the contents of the newURL
        var Parser = TFHpple(HTMLData: htmlData) // use third party Parser downloaded from  [ADD REFERANCE HERE]
        var XPathString = "//table[@class='CarMiniProfile-table']//tr[1]/td[2]" //xpath to search through html data
        var nodes = Parser.searchWithXPathQuery(XPathString) as NSArray // search using xpath and store as NSArray
        
        if(nodes.count == 0 ){ // check if nodes empty
            println("empty nodes!!") // print for testing
            outputMake.textColor = UIColor.redColor() // change colour of text to red
            outputMake.text = "NO MAKE FOUND" // output error message
        }else{
            // nodes found
            for element in nodes
            {
            
                
                
               let tempmake = element.content // set temp make as element from results
                // trim make by removing white spaces and new lines
               let maketrimmed = (tempmake as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                println(maketrimmed)// print for testing
                outputMake.textColor = UIColor.blackColor()// change colour of text to black if not already
                outputMake.text = maketrimmed // output make to user
               RegisterVariables.make = maketrimmed // store make in register Variable structure
            }//end nodes
        }// end else
        
    }// end function fetch make
    
    func FetchModel() {
        // NSURL using RAC website and users numberplate to perform screenscrape
        var newURL = NSURL(string: "https://www.rac.co.uk/buying-a-car/car-passport/report/buyer/purchase/?BuyerVrm=\(numplate.text)")
        var htmlData: NSData = NSData(contentsOfURL: newURL!)!// create data of NSData using the contents of the newURL 
        var Parser = TFHpple(HTMLData: htmlData)// use third party Parser downloaded from  [ADD REFERANCE HERE]
        var XPathString = "//table[@class='CarMiniProfile-table']//tr[2]/td[2]" //xpath to search through html data
        var nodes = Parser.searchWithXPathQuery(XPathString) as NSArray // search using xpath and store as NSArray
        
        
        if(nodes.count == 0 ){ // check if nodes empty
            println("empty nodes") // print for testing
            outputModel.textColor = UIColor.redColor() // change colour of text to red
            outputModel.text = "NO MODEL FOUND" // print error to user 
            
        }else{
            for element in nodes
            {
                
                let tempmodel = element.content // set temp model as element from results
                // trim results and remove line brakes and white spaces
                let modeltrimmed = (tempmodel as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                println(modeltrimmed) // print for testing
                outputModel.textColor = UIColor.blackColor() //change colour to black
                outputModel.text = modeltrimmed // output results to user
                RegisterVariables.model = modeltrimmed // store model in Register Variable Structure
                
            }//end nodes
        }// end else
        
    }// end function
    
    @IBAction func btnNext(sender: AnyObject) {
        
        if numplate.text.isEmpty{ //check if numberplate is empty
            // no num plate error
            outputError.text = " no numberplate entered" // print error
            
        }else{
            // contuine
            
            if (outputMake.text == "" || outputModel.text == "") //check if make or model is blank
            {
               // make and model not found
                outputError.text = "no car found" // print error
                
                
            }else{
                
                performSegueWithIdentifier("SeagueNext1", sender: nil) // perform seague and change view
            }// end second else
            
        }// end first else
    } // end button next function
    
    
    

    @IBAction func BtnNext1(sender: AnyObject) {
        // check if any fields are missing before contuinue
        if (outFullName.text.isEmpty ||
            OutAddress.text.isEmpty ||
            OutContact.text.isEmpty ){
                // fields empty give error
                error2.text = "one or more fields missing" // print error
                
        }else{
            // fields full continue
            //save users values in Register Variable Structure
            RegisterVariables.name = outFullName.text
            RegisterVariables.address = OutAddress.text
            RegisterVariables.contact = OutContact.text
            RegisterVariables.dob = outDob.date
            
            performSegueWithIdentifier("SeagueNext2", sender: nil) // perform seague and change view
            
            
        } // end else
    } // end button next 1 function
    
    
    @IBAction func BtnSubmit(sender: AnyObject) {
        // check if any fields are missing before contuining
        if (outUsername.text.isEmpty ||
            outEmail.text.isEmpty ||
            OutPassword.text.isEmpty ||
            OutputPasswordConfirm.text.isEmpty){
                // information missing error
                error3.text = "one or more fields missing" // print error
                
                
        }else{
            //contine
            
            if (OutputPasswordConfirm.text == OutPassword.text) // check if passwords match
            {
                //passwords match
                println("passwords match")// print for testing
                
                //store user values in Register Variables Structure
                RegisterVariables.username = outUsername.text
                RegisterVariables.email = outEmail.text
                RegisterVariables.password = OutPassword.text
            
                
                var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)// app deledate of shared application delegate
                
                var context:NSManagedObjectContext = appDel.managedObjectContext! // contect of NSMANAGED OBJECT
                
                var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! NSManagedObject // new user as NSMANAGED object for core data intering into new object
                
                
                // set value from new user database using the key provided and of veriable provided
                newUser.setValue(RegisterVariables.username, forKey: "username")
                newUser.setValue(RegisterVariables.password, forKey: "password")
                newUser.setValue(RegisterVariables.name, forKey: "name")
                newUser.setValue(RegisterVariables.address, forKey: "address")
                newUser.setValue(RegisterVariables.dob, forKey: "dob")
                newUser.setValue(RegisterVariables.email, forKey: "email")
                newUser.setValue(RegisterVariables.numberplate, forKey: "numberplate")
                newUser.setValue(RegisterVariables.make, forKey: "make")
                newUser.setValue(RegisterVariables.model, forKey: "model")
                newUser.setValue(RegisterVariables.contact, forKey: "contact")
                
                context.save(nil) // save
                
                // print for testing
                println(RegisterVariables.name)
                println(RegisterVariables.address)
                println(RegisterVariables.contact)
                println(RegisterVariables.email)
                println(RegisterVariables.username)
                println(RegisterVariables.make)
                println(RegisterVariables.model)
                println(RegisterVariables.numberplate)
                println(RegisterVariables.dob)
             
                println("saved") // print for testing
                
                
                
                
                
                performSegueWithIdentifier("SeagueSubmit", sender: nil) // peform seague for next screen
                
                
            }else{
                //passwords dont match
                error3.text = "Passwords do not match"
            } // end else paswords dont match
            
            
        } // end contuine else
        
        
    } // end button submit

}// end class