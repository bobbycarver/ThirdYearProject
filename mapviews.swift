//
//  mapviews.swift
//  
//
//  Created by Bobby Carver on 22/03/2016.
//
//

import UIKit // import UIKit
import MapKit // mapkit
import CoreLocation // location

class mapviews: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager() // location manager as CLLocationManager
    
    //objects from view controller
    
    @IBOutlet weak var tbdisplaylocation: UITextField!
    
    @IBOutlet weak var showmap: MKMapView!
    
    @IBOutlet weak var lblerror: UILabel!
    
    var lat = "" // lat as empty
    
    var long = "" // long as empty
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager = CLLocationManager()// turns location manager into CLlOCATIONManager
        
        locationManager.delegate = self // sets delegate to self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // gets the best accuracy posible for location
        
        locationManager.requestWhenInUseAuthorization() // sends request to get the users location
        
        locationManager.startUpdatingLocation() // start updating location
    
        locator() // run locator function
       
    }
    
    
    func locator(){
        
        showmap.showsUserLocation = true // show users location on map as true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) { // location manager function
        
        let location = locations.last as! CLLocation // set location as las location
        
        // center of map
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        // region
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        self.showmap.setRegion(region, animated: true) // sets the region
        
         long = "\(location.coordinate.longitude)" // long as longitude
        
         lat = "\(location.coordinate.latitude)" // lat as latitude
        
    } // end function did update locations
    
    
    
    @IBAction func BtnType(sender: AnyObject) { // map type
        
        if showmap.mapType == MKMapType.Standard {// if standard is set then set satellite
            
            showmap.mapType = MKMapType.Satellite // set to satellite
            
        } else {
            
            showmap.mapType = MKMapType.Standard // set to standard
            
        } // end else
        
    } // end button type
    
    
    
    @IBAction func BtnStreet(sender: AnyObject) {
        
        fetchaddress() // run fetch address function
        
    }
    
    
    @IBAction func BtnNext7(sender: AnyObject) {
        
        globals.flag = 8 // flag set to 8
        
        performSegueWithIdentifier("SeagueNext7", sender: nil) // perform seague to change view controller
        
    }//end button 7
    
    
    func fetchaddress() { // fetch address
        
        let urladdress = "http://nominatim.openstreetmap.org/reverse?format=json&lat=\(lat)&lon=\(long)&zoom=18&addressdetails=1" // API based on users latitude and longitude
        
        //print for testing
        print(lat)
        print(long)
        
        let nsUrl = NSURL(string: urladdress.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)// create of NSURL
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()) // create session of NS URL session
        
        let task = session.dataTaskWithURL(nsUrl!){ (data, response, error) in // create task of session
            
            var jasonError : NSError? // jason error of type NS ERROr
            
            let jason = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jasonError) as! NSDictionary // jason veriable using NS SERIlazaion and of type NSDICTIONARY
            
            println(jason) // print for testing
            
            
            if let unWrapError = jasonError{ // check if error
                
                println("Error: \(unWrapError)") // print error
                
            }else{ // else no error
                
                print(jason)// print jason to log for testing
                
                
                var disp = jason.valueForKey("display_name") as! String // value from jason as disp
                
                globals.userlocation = "\(disp)" // store disp as globals user location
                
                println(disp) // print for testing
               
                println(globals.userlocation) // print for testing
                
               self.tbdisplaylocation.text = globals.userlocation // text field as user location
                
            
            } // end else
            
        } // end let task
        
        task.resume() // task resume
        
    } // end of function for modeld data
    
} // end class 
