
//
//  FileReport.swift
//  
//
//  Created by Bobby Carver  on 07/03/2016.
//
//

import UIKit // import uikit
import CoreData // import coredata
import Foundation // import foundation
import MapKit // mapkit
import CoreLocation // location



//  globals structre for saving data from reports
struct globals {
    static var flag = 0
    static var makes = ""
    static var numberplates = ""
    static var model = ""
    static var name = ""
    static var email = ""
    static var address = ""
    static var contact = ""
    static var otherName = ""
    static var otherAddress = ""
    static var otherContact = ""
    static var otherInsurance = ""
    static var otherNumberPlate = ""
    static var othermake = ""
    static var othermodel = ""
    static var datentime = ""
    static var userlocation = ""
    static var wit1name = ""
    static var wit1address = ""
    static var wit1contact = ""
    static var wit2name = ""
    static var wit2address = ""
    static var wit2contact = ""
    static var desc = ""
    static var fault = ""
    static var emergancy = ""
    static var police = ""
    static var ambulance = ""
    static var fire = ""
    
    
}
class FileReport: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    
     // objects from view controllers
    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var tbAddress: UITextField!
    @IBOutlet weak var tbContact: UITextField!
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var lblerror1: UILabel!
    //car info
    @IBOutlet weak var tbMake: UITextField!
    @IBOutlet weak var tbNumberPlate: UITextField!
    @IBOutlet weak var tbModel: UITextField!
    @IBOutlet weak var lblerror2: UILabel!
    //other party driver
    @IBOutlet weak var lblerror3: UILabel!
    @IBOutlet weak var tbOtherName: UITextField!
    @IBOutlet weak var tbOtherAddress: UITextField!
    @IBOutlet weak var tbOtherContact: UITextField!
    @IBOutlet weak var tbOtherInsurance: UITextField!
    // other party car
    @IBOutlet weak var tbOtherNumberPlate: UITextField!
    @IBOutlet weak var tbOtherMake: UITextField!
    @IBOutlet weak var tbOtherModel: UITextField!
    @IBOutlet weak var lblerror5: UILabel!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    // date and time 
    @IBOutlet weak var tbDate: UITextField!
    @IBOutlet weak var tbTime: UITextField!
    @IBOutlet weak var lblerror7: UILabel!
    //witness information
    @IBOutlet weak var lblerror8: UILabel!
    @IBOutlet weak var tbwitnessname1: UITextField!
    @IBOutlet weak var tbwitnessaddress1: UITextField!
    @IBOutlet weak var tbwitnesscontact1: UITextField!
    //second witness information
    @IBOutlet weak var lblerror9: UILabel!
    @IBOutlet weak var tbwitnessname2: UITextField!
    @IBOutlet weak var tbwitnessaddress2: UITextField!
    @IBOutlet weak var tbwitnesscontact2: UITextField!
    // event logg
    @IBOutlet weak var lblerror10: UILabel!
    @IBOutlet weak var tbdesc: UITextView!
    @IBOutlet weak var emergancyswitch: UISwitch!
    @IBOutlet weak var faultswitch: UISwitch!
    // emergancy log
    
    @IBOutlet weak var policeSwitch: UISwitch!
    @IBOutlet weak var ambulanceSwitch: UISwitch!
    @IBOutlet weak var FireSwitch: UISwitch!
    

    
    
    var locationManager: CLLocationManager! // location manager of CCLocation manager
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if globals.flag == 0 || globals.flag == 1 { // if the flag is 0 or 1
            self.getDetails() // run get details function
            if globals.flag == 1 { // if the flag is 1
                getcarinfo() // run get car info function
            } // end if 1
        
        } // end if 1 or 0
        if globals.flag == 8 { // if the flag is 8
            getdatetime() // run get date and time function
           
        } // end if 8
        
            
   

        // Do any additional setup after loading the view.
    } // end view did load
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldAutorotate() -> Bool { // override AutoRorate function from Stackoverflow fourm
        //LINK: http://stackoverflow.com/questions/2516491/how-to-check-in-which-position-landscape-or-portrait-is-the-iphone-now
        
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || // if landscape left or
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight || // if llandscape right or
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) { // if orientation  not known
                return false; // return false
        }
        else { // end not false
            return true; // return true
        }
    } // end should auto rotate

    
    
    func getDetails() { // func get details
        
        var userID = MyVariables.trackuser // set user ID of track user
       
        
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
            var loadednumberplate = r.valueForKey("numberplate") as! String
            var loadedmake = r.valueForKey("make") as! String
            var loadedmodel = r.valueForKey("model") as! String


           // turn screen object to string
            globals.name = "\(loadedname)"
            globals.email = "\(loadedemail)"
            globals.address = "\(loadedaddress)"
            globals.contact = "\(loadedcontact)"
            globals.numberplates = "\(loadednumberplate)"
            globals.makes = "\(loadedmake)"
            globals.model = "\(loadedmodel)"

            // print for testing
            println(loadedname)
            println(loadedemail)
            println(loadedaddress)
            println(loadedcontact)

            
            if globals.flag == 0 { // if flag is 0
               getprofileinfo() // run get profile info function
                
            }// end if 0
            if globals.flag == 1 { // if flag is 1
                getcarinfo() // run get car info function
                globals.flag = 3 // set flag to a non useable variable
            }// end if 1

            
            
            
        }else{//else no records found
            
            println("Nothing returned") //print for testing
            
            
        }// end else no records
        
        println("Load") // print for testing
        
    } // end function  get details 
    
    
    
    func getcarinfo(){
        // set text fields as values found from get details function
        tbNumberPlate.text = globals.numberplates
        tbMake.text = globals.makes
        tbModel.text = globals.model
    }
    
    
    func getprofileinfo(){
        // set text fields as values found from get details function
        tbName.text = globals.name
        tbEmail.text = globals.email
        tbAddress.text = globals.address
        tbContact.text = globals.contact
        
    }
    
    
    
    
    @IBAction func btnNext(sender: AnyObject) {
        if( tbName.text.isEmpty || tbAddress.text.isEmpty || tbContact.text.isEmpty || tbEmail.text.isEmpty){ // check if one or more fields empty
            // error
            lblerror1.text = " one or more fields missing" // prints error
            
        }else{
            // else continue
            globals.flag = 1 // set flag to 1
            performSegueWithIdentifier("SeagueNext1", sender: nil) // perform seague to change view 
            
            
           
            
        } // end else
        
    } // end button next
    
        
    @IBAction func BtnNext2(sender: AnyObject) {
        if(tbNumberPlate.text.isEmpty || tbMake.text.isEmpty || tbModel.text.isEmpty){ // check if one or more fields empty
            
            lblerror2.text = "one or more fields missing" // print error
            
        }else{
            
            // continue
            
            performSegueWithIdentifier("SeagueNext3", sender: nil) // perform seague to change view
            
            
        } // end else
    } // end button 2
    
    
  
    @IBAction func BtnNext3(sender: AnyObject) {
        if(tbOtherName.text.isEmpty || tbOtherAddress.text.isEmpty || tbOtherContact.text.isEmpty || tbOtherInsurance.text.isEmpty){// check if one or more fields empty
            //error
            lblerror3.text = " one or more fields missing" // print error
            
            
        }else{
            // contuine 
            
            //set globals variable stucture to information from text fields
            globals.otherName = tbOtherName.text
            globals.otherAddress = tbOtherAddress.text
            globals.otherContact = tbOtherContact.text
            globals.otherInsurance = tbOtherInsurance.text
            
        }// end else
        
        // contuine after saving
        performSegueWithIdentifier("SeagueNext4", sender: nil) // perform seague to change view
    } // end button 3
    
    
    // SOME CODE USED FROM ray wendlerlich TUTORIALS FOR TESSERACT IMAGE RECOGNITION FRAMEWORK BY GOOGLE
    // Link: https://www.raywenderlich.com/93276/implementing-tesseract-ocr-ios
    
    
    @IBAction func btnTakePic(sender: AnyObject) {
        
        view.endEditing(true) // end end eddit to true
        
        
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",message: nil, preferredStyle: .ActionSheet) // image picker action sheet presented to user
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) { // if camera is available
            
            let cameraButton = UIAlertAction(title: "Take Photo", style: .Default) { (alert) -> Void in // let camera button as take photo
                let imagePicker = UIImagePickerController() // image picker as UIImagePickerController
                imagePicker.delegate = self // delegae as self
                imagePicker.sourceType = .Camera // source type as camera
               
                self.presentViewController(imagePicker,animated: true,completion: nil) // show to user
                
                        }// end let camera button 
            
            imagePickerActionSheet.addAction(cameraButton)// add camera button to action sheet
            
        }// end if camera available 
        
        
        let libraryButton = UIAlertAction(title: "Choose Existing",style: .Default) {(alert) -> Void in // let libary button as follows
            
                let imagePicker = UIImagePickerController() // image picker from UIImagePickerController
            
                imagePicker.delegate = self// delegate as self
            
                imagePicker.sourceType = .PhotoLibrary// source type as photolibary
            
                self.presentViewController(imagePicker, animated: true, completion: nil)//show to user
            
        }// end of let libary button
        
        imagePickerActionSheet.addAction(libraryButton)// add libary button to action sheet
        
        let cancelButton = UIAlertAction(title: "Cancel",style: .Cancel) { (alert) -> Void in} // let cancel button
        
        imagePickerActionSheet.addAction(cancelButton) // add cancel button to action sheet
        
        
        presentViewController(imagePickerActionSheet, animated: true,completion: nil)// show action sheet to user
        
    }// end function take picture
    
    
    
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage { // function takes in image and max dimention and gives out an image
    
    var scaledSize = CGSize(width: maxDimension, height: maxDimension) // scaled size as CGSize using with and height as MaxDimension
        
    var scaleFactor: CGFloat // scale factor as CGFloat
    
    if image.size.width > image.size.height { // if image width less than image height
        
    scaleFactor = image.size.height / image.size.width // scale facotr as height / width
        
    scaledSize.width = maxDimension // scaled size as max dimention
        
    scaledSize.height = scaledSize.width * scaleFactor // scaled size height as width multipled by scalefactor
        
    } else {
        
    scaleFactor = image.size.width / image.size.height // scale factor is width /  height
        
    scaledSize.height = maxDimension // scaled size height as max dimension
        
    scaledSize.width = scaledSize.height * scaleFactor // scaed size width as height multipled by scalefactor
        
    } // end if
    
    UIGraphicsBeginImageContext(scaledSize) // pass scaled size
        
    image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height)) // scale image
        
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // set scaled image as current image context
        
    UIGraphicsEndImageContext() // end context
    
    return scaledImage // return scaled image
        
    } // end function scale image 
    
    
    
    func performImageRecognition(image: UIImage) {
        
      
        
        let tesseract = G8Tesseract() // set tesseract as G8Tesseract third party framework
        
        tesseract.language = "eng+fra" // set tesseract lanage to english and french
        
        tesseract.charWhitelist = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqurstuvwxyz. " // set white characterlist as numbers and alphabet in both forms
        
        tesseract.engineMode = .TesseractCubeCombined // set engine mode as cube combined for best accuracy but slower time
        
        tesseract.pageSegmentationMode = .Auto // page segmentation mode as auto
        
        tesseract.maximumRecognitionTime = 60.0 // set max time allowed as 60 seconds
        
        tesseract.image = image.g8_blackAndWhite() // change image to black and white
        
        tesseract.recognize() // run recognize function
        
        let readplate = tesseract.recognizedText // set read numberplate as recognized text
        
        
        
        let tempplate = tesseract.recognizedText // set template as recognised text
        
        // trim plate to remove white charector spaces and new lines
        
        let platetrimmed = (tempplate as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        println(platetrimmed) // print for testing 
        
        
        tbOtherNumberPlate.text = platetrimmed // set number plate field to value
        
        globals.otherNumberPlate = platetrimmed // set global field to new value
        
        println(globals.otherNumberPlate) // print for testing
        
       
        
    } // end perform image recogition function
    
    
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            
             self.activityindicator.startAnimating() //start indiciator
            
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage // let selected photo as UIIMage
            
            let scaledImage = scaleImage(selectedPhoto, maxDimension: 640) // let scaledimage as scaleimage of selected photo using max dimensions 640
            
           
            // dismiss view
            dismissViewControllerAnimated(true, completion: {
               
                self.performImageRecognition(scaledImage)
                
                self.activityindicator.stopAnimating() // stop activitiy indicator
            })
            
            
    } //end did finish picking media function
    
    
    @IBAction func GetCarinfo(sender: AnyObject) {
        
        if tbOtherNumberPlate.text.isEmpty { // check if number plate is empty
            
            //error
            
            lblerror5.text = "number plate missing" // set label as error
            
        }else{
            // contuine
            
        
     globals.otherNumberPlate = tbOtherNumberPlate.text // set globals as new numberplate
            
     FetchMake() // fun fetch make function
            
     FetchModel() // fun fetch model function
            
        }// end else
        
    }// end get car info function
    
    
    func FetchModel() {
        
       
        let urlgetcar = "https://www.rac.co.uk/buying-a-car/car-passport/report/buyer/purchase/?BuyerVrm=\(globals.otherNumberPlate)" // screen scape using users numberplate
        
        let newURL = NSURL(string: urlgetcar.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!) // create of NSURL and add percent escapes for spaces
        
        var htmlData: NSData = NSData(contentsOfURL: newURL!)! // html data from contents of newURL
        
        var Parser = TFHpple(HTMLData: htmlData) // Parser of TFHpple Third party framework
        
        var XPathString = "//table[@class='CarMiniProfile-table']//tr[2]/td[2]" // xpath string to search for data through thml
        
        var nodes = Parser.searchWithXPathQuery(XPathString) as NSArray // nodes as parser using xpath query and store results as array
        
        if(nodes.count == 0 ){ // if nodes is 0
            
            println("empty nodes") // print for testing
            
            tbOtherModel.textColor = UIColor.redColor() // set text colour to red
            
            tbOtherModel.text = "NO MODEL FOUND" // print error to user
            
        }else{
            // found nodes 
            
            for element in nodes
                
            {
                
                let tempmodel = element.content // set temp model as element content
                // model trimmed by removing all white spaces
                let modeltrimmed = (tempmodel as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                println(modeltrimmed) // print for testing
                
               tbOtherModel.textColor = UIColor.blackColor() // set text colour to black
                
                tbOtherModel.text = modeltrimmed // set text field as model found
                
                globals.othermodel = modeltrimmed // set globals as model value
                
            } // end for
        } // end else
  
    } // end function fetch model
    
    
    func FetchMake() {
        
       
        
        let urlgetcar = "https://www.rac.co.uk/buying-a-car/car-passport/report/buyer/purchase/?BuyerVrm=\(globals.otherNumberPlate)" // screen scrape based on users input on selected make
        
        let newURL = NSURL(string: urlgetcar.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!) // create of NSURL and add percent escaoes
        
        
        var htmlData: NSData = NSData(contentsOfURL: newURL!)! // html data as NSData from contents of URL of newURl
        
        var Parser = TFHpple(HTMLData: htmlData) // set parser as TFHpple third party framework
        //LINK: https://github.com/topfunky/hpple
        
        var XPathString = "//table[@class='CarMiniProfile-table']//tr[1]/td[2]" // xpath string
        
        var nodes = Parser.searchWithXPathQuery(XPathString) as NSArray // set nodes as parser using xpath query and store results as array
        
        if(nodes.count == 0 ){ // if nodes is 0
            
            println("empty nodes") // print for testing
            
            tbOtherMake.textColor = UIColor.redColor() // set text colour to red
            
            tbOtherMake.text = "NO MODEL FOUND" // print error to user
            
        }else{
            
            for element in nodes
                
            {
                
                let tempmake = element.content // set temp make as element content
                
                // trim make by removing all white spaces
                
                let maketrimmed = (tempmake as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                println(maketrimmed) // print for testing
                
                tbOtherMake.textColor = UIColor.blackColor() // set colour of text to black
                
                tbOtherMake.text = maketrimmed // set text field as make value
                
                globals.othermake = maketrimmed // set globals as make value
                

            } // end of for
        } // end else
        
    } // end function fetch make
    
    
    
    @IBAction func BtnNext5(sender: AnyObject) {
        
        if (tbOtherNumberPlate.text.isEmpty || tbOtherMake.text.isEmpty || tbOtherModel.text.isEmpty){ // check if one or more fields missing 
            
            // error
            
            lblerror5.text = "one or more fields missing" // print error to user
            
        }else{
            
            // contuine
            
            performSegueWithIdentifier("Seaguenext5", sender: nil) // perform seague to change view controller
            
        } // end else
        
    } // end button 5 function
    
    
    @IBAction func BtnNext6(sender: AnyObject) {
        
        // image collection to location
       
        performSegueWithIdentifier("SeagueNext6", sender: nil) // perform seague to change view controller
    
    } // end button 6 function
    
    
    
    
    
    
    func getdatetime(){
        
       tbDate.text = globals.datentime // set text field from time and date global
        
         globals.flag = 4 // set globsls flag to 4
        
    } // end function get date and time
    
    
    @IBAction func BtnNext8(sender: AnyObject) {
        
        if tbDate.text.isEmpty { // check if date field is empty
            
            // error
            
            lblerror7.text = " one or more fields missing" // print error to user
            
        }else{
            
            performSegueWithIdentifier("SeagueNext8", sender: nil) // perform seague to change view controller
            
        }// end else
        
        
    } // end button 8 function
    
    
    
    @IBAction func btnBack(sender: AnyObject) {
        
        globals.flag = 8 // set flag to 8
        
    } // end button back function
    
    
    
    @IBAction func BtnNext9(sender: AnyObject) {
        
        //check if one or more empty
        
        if tbwitnessname1.text.isEmpty || tbwitnessaddress1.text.isEmpty || tbwitnesscontact1.text.isEmpty {
            
            // one or more is empty check if all are empty
            
            if tbwitnessname1.text.isEmpty && tbwitnessaddress1.text.isEmpty && tbwitnesscontact1.text.isEmpty {
                
                // all empty continue
                
                performSegueWithIdentifier("SeagueNext9", sender: nil) //perform seague to chance view controller
                
            }
            
            // some fields empty error
            
            lblerror8.text = " one or more fields empty" // print error to user
            
        }else{
            
            
            // set globals to text fields
            
            globals.wit1name = tbwitnessname1.text
            
            globals.wit1contact = tbwitnesscontact1.text
            
            globals.wit1address = tbwitnessaddress1.text
            
            performSegueWithIdentifier("SeagueNext9", sender: nil) // perform seague to change view controller
            
        }// end else
        
    } // end button 9 function
    
    
    @IBAction func BtnNextWit(sender: AnyObject) {
        
        if tbwitnessname1.text.isEmpty || tbwitnessaddress1.text.isEmpty || tbwitnesscontact1.text.isEmpty { // check if one or more fields missing
            
            // one or more missing error
            
            lblerror8.text = " please fill out first witness" // print error to user
            
        }else{
            
            // set globals to text fields
            globals.wit1name = tbwitnessname1.text
            
            globals.wit1contact = tbwitnesscontact1.text
            
            globals.wit1address = tbwitnessaddress1.text
            
            performSegueWithIdentifier("SeagueNextWit", sender: nil) // perform seague to change view controller
            
        } // end else
        
    } //end button next witness function
    
    
    
    
    @IBAction func BtnNext10(sender: AnyObject) {
        
        if tbwitnessname2.text.isEmpty || tbwitnessaddress2.text.isEmpty || tbwitnesscontact2.text.isEmpty { // check if some are empty
            
            // one or more is empty check if all are empty
            
            if tbwitnessname2.text.isEmpty && tbwitnessaddress2.text.isEmpty && tbwitnesscontact2.text.isEmpty { // check if all are empty
                
                // all empty continue
                
                performSegueWithIdentifier("SeagueNext10", sender: nil) // perform seague to change view controller
                
            } // end second if
            
            // some fields empty error
            
            lblerror9.text = " one or more fields empty" // print error to user
            
        }else{
            
            // set globals as text fields
            
            globals.wit2name = tbwitnessname2.text
            
            globals.wit2contact = tbwitnesscontact2.text
            
            globals.wit2address = tbwitnessaddress2.text
            
            performSegueWithIdentifier("SeagueNext10", sender: nil) // perform seague to change view controller
            
        } // end else
        
    } // end button 10 function
    
    
  
    
    @IBAction func BtnNext11(sender: AnyObject) {
        
        if tbdesc.text.isEmpty { // if text empty
            //error
            
            lblerror10.text = "Enter description" // print error to user
            
        }else{
            // continue
            
        if faultswitch.on { // if switch turned on
            
            globals.fault = "Yes" // set fault to yes
            
        }else{
            
            globals.fault = "No" // set fault to no
            
        } // end else
            
        if emergancyswitch.on { // if switch turned on
            
            globals.emergancy = "Yes" // set emergancy to yes
            
            performSegueWithIdentifier("SeagueEmergancy", sender: nil) // perform seague to change view controller
            
            
            
        }else {
            
            globals.emergancy = "No" // set emergancy to no
            
            performSegueWithIdentifier("SeagueNext12", sender: nil) // perform seague to change view controller
            
        } // end else emergancy
            
    } // end else if empty
        
 }// end button 11 function
    
    
    
    
    @IBAction func BtnNext12(sender: AnyObject) {
        
        if policeSwitch.on { // if police on
            
            globals.police = "Yes" // set police to yes
            
        }else{
            
            globals.police = "No" // set police to no
            
        } // end else
        
        if ambulanceSwitch.on { // if ambulance turned on
            
            globals.ambulance = "Yes" // set ambulance to yes
            
        }else{
            
            globals.ambulance = "No" // set ambulance to no
            
        }// end elsen
        
        if FireSwitch.on{ // if fire turned on
            
            globals.fire = "Yes" // set fire to yes
            
        }else{
            
            globals.fire = "No" // set fire to no
            
        } // end else
        
        performSegueWithIdentifier("SeagueFinish", sender: nil) // perform seague to change view controller
        
    } // end button 12 function]
    
    
    }//end class


