//
//  openfiles.swift
//  
//
//  Created by Bobby Carver on 29/03/2016.
//
//

import UIKit // import UIKit

class openfiles: UIViewController {

    //objects from view controller
    @IBOutlet weak var printfiletb: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        openfiles() // run open files function

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func openfiles() {
        
        let file = MyVariables.fileopen // file as fileopen from user click
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] { // dirs as documents directory as string
            
            let dir = dirs[0] //documents directory
            
            let path = dir.stringByAppendingPathComponent(file); // path as dir and file values
            
           
            //reading
            
             var text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) // set text from file
            
            printfiletb.text = text // text field as text
            
        } // end if let dirs
                
    } // end function open files

} // end class
