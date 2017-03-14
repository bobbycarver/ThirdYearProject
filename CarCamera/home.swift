//
//  home.swift
//  
//
//  Created by Bobby Carver on 05/03/2016.
//
//

import UIKit // import UIKIT
import AVFoundation // import avfoundation
import CoreLocation // import corelocation 


class home: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager() // set location manager as CLLocation
    var currentspeed = 00 // set current speed at 00MPH

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization() // request authorization
        locationManager.delegate = self // deleate of self
        locationManager.distanceFilter = kCLDistanceFilterNone //no distance filter
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //best accuracy possible
        locationManager.startUpdatingLocation() // start updating location
        //locationManager.requestWhenInUseAuthorization()
        
        
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,target: self,selector: Selector("settime"),userInfo: nil,repeats: true) // NSTIMer for function tick
        
        
        captureSession.sessionPreset =  AVCaptureSessionPresetLow // set preset to low
        let devices = AVCaptureDevice.devices() // make devices from AVCapture device
        
        for device in devices { // for device in devices
            if (device.hasMediaType(AVMediaTypeVideo)) { // if has video 
                
                
                
                if(device.position == AVCaptureDevicePosition.Back) { //  check if back camera
                    
                    captureDevice = device as? AVCaptureDevice // capture device as ACcapture device
                }// end else on back
            } // end if has video
        } // end for devices
        
        
        if captureDevice != nil { // if capture device is not nil
            beginSession() // begin the session
        } // end of not nill
        

    
        
    } // end of view did load

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // objects from view controller
    @IBOutlet weak var speedlbl: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    
    var timer = NSTimer()// timer as NSTimer 
    
    let captureSession = AVCaptureSession() // capture session as AVCaptureSession
    
    var captureDevice : AVCaptureDevice? // capture device as AVCaptureDevice
    
    
    @objc func settime() {
        timelabel.text = NSDateFormatter.localizedStringFromDate(NSDate(),dateStyle: .MediumStyle,timeStyle: .MediumStyle) // set time on time label
    }// end of set time
    
    
    func printspeed() {
        speedlbl.text = "\(currentspeed)" // prints value of current speed to speed label
    }// end of print speed
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) { // did update locations funtion from cclocationmanagaer
        
        var speed = locationManager.location!.speed //set speed from location manager speed
       
        if speed < 0 { // if speed is less than 0
            speed = 00 //set speed to 00
            speedlbl.text = String(format: "%.0f MPH", speed * 2.23636284) // convert from MPS to MPH by multiplying the speed by 2.23636284
        }else{
            //speed greater than 0
             speedlbl.text = String(format: "%.0f MPH", speed * 2.23636284) // conver from MPS to MPH by multiplying the speed by 2.23636284
        } // end of else
        
        
    } // end of did update locations function
    
    
    func beginSession() {
        var err : NSError? = nil // error nil
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err)) // add inout to capture session
        
        if err != nil { // if error is not nill
            println("error: \(err?.localizedDescription)") // print error
        } // end if error
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) // preview layer as avCaptureVideo preview layer
        self.view.layer.addSublayer(previewLayer) // add sub layer of preview layer
        previewLayer?.frame = self.view.layer.frame // frame of previewlayer as self layer frame
        captureSession.startRunning() // start running capture session
    } // end of begin session function
    

    @IBAction func SignOut(sender: AnyObject) {
        MyVariables.trackuser = "" // set track user to nil
          performSegueWithIdentifier("SeagueSignOut", sender: nil) // seague to sign out screen
    } // end function sign  out
    
    
    func crashpopup() {
        // set alert of UIAlerController with the following values
        let alert = UIAlertController(title: "CRASH DETECTED", message: "would you like to fill out a report?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: { action in // add yes button
            
            // launch report file
            let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle) // set time stamp as current time
            globals.datentime = "\(timestamp)" // save the time stamp in globals structure for report
            
            
            self.performSegueWithIdentifier("SeagueFileReport", sender: nil) // seague to file report view
            
            
        })) // end of add action
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)) // add action No
        
        
        self.presentViewController(alert, animated: true, completion: nil) // show the alert
        
    } // end crash pop up function
    
    func assistancePopUp(){
        
        // set alert as UIAlert controller with the following values
        let alert = UIAlertController(title: "CRASH DETECTED", message: "do you need emergancy assistance via 999", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: { action in // add yes button
            
            let phone = "tel://999"; // let phone to tel://999 for emergancy calls
            let url:NSURL = NSURL(string:phone)!; // let url as NSURL using phone value
            UIApplication.sharedApplication().openURL(url); // open URL of url to phone number
            
            
        })) // close yes button
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Destructive, handler: { action in // no button
            
            self.crashpopup() // run the next pop up function
            
            
        })) // end no  button
        
        self.presentViewController(alert, animated: true, completion: nil) // show the alert
        
       
    } // end assistance pop up function 
    
    
    @IBAction func FuncSimulate(sender: AnyObject) {
        // simulate crash button for testing purpose
        
        assistancePopUp() // run first pop up
        
        
    } // end function simulate 
} // end class

