//
//  imageview.swift
//  
//
//  Created by Bobby Carver on 29/03/2016.
//
//

import UIKit // Import UIKit
import Foundation // import Foundation

class imageview: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // objects from view controler
    @IBOutlet weak var imagepreview: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BtnTakePicture(sender: AnyObject) {
        
        view.endEditing(true) // end editing as true 
        
        // add to image action sheet with the following values
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",message: nil, preferredStyle: .ActionSheet)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let cameraButton = UIAlertAction(title: "Take Photo", style: .Default) { (alert) -> Void in // let camera button
                
                let imagePicker = UIImagePickerController() // image picker as UIImagepickercontroller
                
                imagePicker.delegate = self // delegate as self
                
                imagePicker.sourceType = .Camera // source type as camera
                
                self.presentViewController(imagePicker,animated: true,completion: nil)  // show to user
                
            }// end let camera button
            
            imagePickerActionSheet.addAction(cameraButton) // add to action sheet
        }
       
        let libraryButton = UIAlertAction(title: "Choose Existing",style: .Default) {(alert) -> Void in // let libary button
            
                let imagePicker = UIImagePickerController() // image picker of UIImagepickerController
                
                imagePicker.delegate = self // delegate as self
            
                imagePicker.sourceType = .PhotoLibrary // source type as photo libary
            
                self.presentViewController(imagePicker, animated: true, completion: nil) //show to user
            
        }// end let libary button
        
        imagePickerActionSheet.addAction(libraryButton) // add to action sheet
        
        let cancelButton = UIAlertAction(title: "Cancel",style: .Cancel) { (alert) -> Void in } // cancel button
        
        imagePickerActionSheet.addAction(cancelButton) //add cancel button
        
        presentViewController(imagePickerActionSheet, animated: true,completion: nil) //show to user
        
    } // end take pic function
    
   
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage // selected photo as UIImage
            
            imagepreview.image = selectedPhoto // image picker image as selected photo
            
            dismissViewControllerAnimated(true, completion: {}) // dismiss view
            
    } // end did finish with media info
    
} // end class



