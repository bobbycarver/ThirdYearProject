//
//  savereportViewController.swift
//  
//
//  Created by Bobby Carver  on 28/03/2016.
//
//

import UIKit // import UIKit
import MessageUI // message UI for emails

class savereportViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let file = "\(MyVariables.trackuser)report0.txt" // default file name using trackeduser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(sender: AnyObject) {
        
        saverep(checkfileexists(file)) // run save report function passing in file exists function with default file name
    }
    
    
    @IBAction func BtnEmail(sender: AnyObject) {
        
        //Check to see the device can send email.
        if( MFMailComposeViewController.canSendMail() ) {// checks if email can be sent
            
            println("Can send email.") // print to console
            
            let mailComposer = MFMailComposeViewController() // set mail composer of MFmail
            
            mailComposer.mailComposeDelegate = self // sets delegte of self
            
            //Set the subject and message of the email
            
            mailComposer.setSubject("Crash Report Log")// sets subject
            
            mailComposer.setMessageBody("File attatched contains the crash log submitted", isHTML: false) // set message to body
            
            
            
            if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
                
                let dir = dirs[0] //documents directory
                
                let path = dir.stringByAppendingPathComponent(MyVariables.useablefilename)
                println("File path loaded.") // prints to log
                
                let fileData = NSData(contentsOfFile: path) // sets file data from file
                
                println("File data loaded.") // print for testing
                
                mailComposer.addAttachmentData(fileData, mimeType: "Text", fileName: "crashreport") // adds attachment
                
            } // end of let DIRS
            
            self.presentViewController(mailComposer, animated: true, completion: nil) // show to user
        }
        
    } // end of button email
    
    
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)// dismiss mail sender once finished
    }
    
    func checkfileexists(oldfilename: String) -> String{
        
        var index = 0 // index as 0 for file name 
        
        var flag = 0 // flag as 0 for loop
        
        var newfile = oldfilename //  new file as old file passed in paramenter
        
        let user = MyVariables.trackuser // user as tracked user
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String // paths as document directory as string
        
        while flag == 0 { // while flag is set to 0
            
        let filepath = paths.stringByAppendingPathComponent(newfile) // addend file path components using paths and file name
        
        let checkValidation = NSFileManager.defaultManager() // check validation as NSFilemanager
        
        
        if (checkValidation.fileExistsAtPath(filepath)) // if file exsists at file path
        {
            //file located
            
            // change file name
            
            newfile = "\(user)report\(index).txt"// set new file name with new incremented value of index
            
            index += 1 // increment index by 1
        }
            
        else
            
        {
            
          //file not located keep file name
            
            flag = 1 // change flag to 1 to stop loop
            
            MyVariables.useablefilename = newfile // save new file name
            
        } // end else
            
      } //end while loop
        
        return newfile // return new file name
        
    } // end check file function
    
    
    
    func saverep(passfilename: String){ // save report with parameter as file name
        
        let newfilename = passfilename // file name as passed file name
        
        // create strings based on information given
        
        var locationn = globals.userlocation
        
        let Document = " My Name: \(globals.name)\n My Address: \(globals.address)\n My Contact Number: \(globals.contact)\n My car is a \(globals.makes) \(globals.model) with the registration \(globals.numberplates).\n On the \(globals.datentime) I had a vehicle collision with \(globals.otherName) at \(locationn) Their information is as follows:\n Name: \(globals.otherName)\n Address: \(globals.otherAddress)\n Contact number \(globals.otherContact)\n Insureance Company: \(globals.otherInsurance)\n Their car is a \(globals.othermake) \(globals.othermodel) with the registration \(globals.otherNumberPlate).\n The following are witness information for the two main witnesses (if any).\n ===== Witness 1 =====\n Name: \(globals.wit1name)\n address: \(globals.wit1address)\n Contact information: \(globals.wit1contact)\n ===== Witness 2 ===== \n Name: \(globals.wit2name)\n address:\(globals.wit2address)\n Contact information: \(globals.wit2contact)\n ===== Fault and Emergancy Services ===== \n Was \(globals.name) at Fault? \(globals.fault)\n Was the emergancy srvices called? \(globals.emergancy)\n Police:  \(globals.police)\n Ambulance: \(globals.ambulance)\n Fire Service: \(globals.fire)\n  " // \n for line brakes
        
       
        
        
        
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] // let dirs as document directory as string
        
        if (dirs != nil) { // if dirs is not nil 
            
            let directories:[String] = dirs! // let directories as dirs
            
            let dirs = directories[0]; //documents directory
            
            let path = dirs.stringByAppendingPathComponent(newfilename); // path using new filename and dirs
            
            let text = Document // set text as document
            
            //write to file 
            
            text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
            
            
            var error:NSError? // error of NSError 
            
            if let theError = error { // check error
                
                print("\(theError.localizedDescription)") // print error
                
            } // end error check
            
        } // end dirs not nil
        
        
    } // end save report function
    
    
   } //end class