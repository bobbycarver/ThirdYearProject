//
//  settingsTableViewController.swift
//  
//
//  Created by Bobby Carver on 23/03/2016.
//
//

import UIKit // import UIKit
import MobileCoreServices //import mobile core services
import AssetsLibrary// import assets libary
import Foundation // import foundation

class settingsTableViewController: UITableViewController, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var settings = [setting]() // array of objects from setting class

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadsettings() // run loadsettings function

            }
    
    
    
    func loadsettings(){
        
        let photo1 = UIImage(named: "exit")! // photo as exit from image cassets
        let setting1 = setting(name: "Back", photo: photo1)! // setting object with value and photo
        
        let photo2 = UIImage(named: "Signoutimg")!
        let setting2 = setting(name: "Sign Out", photo: photo2)!
        
        let photo3 = UIImage(named: "Settings")!
        let setting3 = setting(name: "Settings", photo: photo3)!
    
        let photo4 = UIImage(named: "Profile")!
        let setting4 = setting(name: "Profile", photo: photo4)!
        
        let photo5 = UIImage(named: "MyCar")!
        let setting5 = setting(name: "My Car", photo: photo5)!
        
        let photo6 = UIImage(named: "EmergancyContactsimg")!
        let setting6 = setting(name: "Emergancy Contacts", photo: photo6)!
        
        
        let photo7 = UIImage(named: "ViewVideos")!
        let setting7 = setting(name: "View Videos", photo: photo7)!
        
        
        let photo8 = UIImage(named: "ViewReports")!
        let setting8 = setting(name: "View Reports", photo: photo8)!
        
        settings += [setting1,setting2,setting3,setting4,setting5,setting6,setting7,setting8] //update array with new objects
        
    }// end load settings
    
    func videoview() {
        
        // if source is availbe
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            
            
            let imagePicker = UIImagePickerController() // imagepicker as UIImagePickercontroller
            
            imagePicker.delegate = self // delegate as self
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum; // source type as saved album
            
            imagePicker.mediaTypes = [kUTTypeMovie as String] // media type as type movie as string
            
            imagePicker.allowsEditing = false // allow editing as false
            
            self.presentViewController(imagePicker, animated: true, completion: nil) // show to user
            
        } // end if
        
    } // end function video view
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        self.dismissViewControllerAnimated(true, completion:nil) // dismiss view controller
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

   

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return settings.count // return item count in array
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "settingcell" // cell id as settingcell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! settingsTableViewCell // create cell using cellID and indexPath and as settings custom cell
        
        let setting = settings[indexPath.row] // let setting as settings array number as indexpath.row
        
        cell.namelabel.text = setting.name // cell label as object name
        
        cell.photoimgview.image = setting.photo // cell photo as settings photo
        
        return cell // return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        /// change paths based on index row
        
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("exitSeague", sender: nil)
        }
        if indexPath.row == 1 {
            self.performSegueWithIdentifier("SeagueSignOut", sender: nil)
        }
        if indexPath.row == 2 {
            //settings 
            self.performSegueWithIdentifier("SettingsSeague", sender: nil)
            
        }
        if indexPath.row == 3 {
            self.performSegueWithIdentifier("SeagueMyProfile", sender: nil)
        }
        if indexPath.row == 4 {
            self.performSegueWithIdentifier("SeagueLoadCar", sender: nil)
        }
        if indexPath.row == 5 {
            //emergancy contacts
        }
        if indexPath.row == 6 {
            videoview()
        }
        if indexPath.row == 7 {
            //view report
            self.performSegueWithIdentifier("SeagueReports", sender: nil)
        }
    } // end did select row at index path 

} // end class
