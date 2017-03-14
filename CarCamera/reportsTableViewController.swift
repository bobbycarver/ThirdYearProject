//
//  reportsTableViewController.swift
//  
//
//  Created by Bobby Carver  on 29/03/2016.
//
//

import UIKit

class reportsTableViewController: UITableViewController {
    
     var listOfFiles = [] //empty array of listoffiles
    
     var selectedfile: String! // selected file as string
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchFilesFromFolder() //run fetchfilesfromfolder function

            }
    
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listOfFiles.count // return number of items in list of files array
        
    }
    
    
    func fetchFilesFromFolder() {
        
        var fileManager = NSFileManager.defaultManager() //filemanager as NSFileManager
        
        var folderPathURL = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as! NSURL //path of documents
        
        var documentsContent = fileManager.contentsOfDirectoryAtPath(folderPathURL.path!, error: nil) //content of documents
        
        println(documentsContent) //print for testing
        
        //directory urls as contents of directoryatUrl using following properties
        if var directoryURLs = fileManager.contentsOfDirectoryAtURL(folderPathURL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: nil) {
            
            println(directoryURLs) //print for testing
            
            //report files as directory and filter using path extension txt and last path component
            var reportFiles = directoryURLs.map(){ $0.lastPathComponent }.filter(){ $0.pathExtension == "txt" }
            
           
           
            listOfFiles = reportFiles // add report files to list of files array
            
            println(reportFiles) //print for testing
            
        } // end contents of directory
        
    } // end function fetc files from folder

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cellIdentifier = "reportcell" // cell identifier as reportcell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! settingsTableViewCell //create cell as custom cell class using cell identifier
        
        
         cell.textLabel?.text = listOfFiles[indexPath.row] as? String // cell text label as list of files index
        
        return cell // return cell
        
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow() // index path as indexath for selected row
        
        //current cell as cellfor row at index path using custom cell class
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! settingsTableViewCell
        
        selectedfile = currentCell.textLabel!.text! // selectedfile as current cell label text
        
        println(selectedfile!) // print for testing
        
        MyVariables.fileopen = selectedfile! // file open as selected file
        
        performSegueWithIdentifier("SeagueOpenFile", sender: nil) // perform seague to change view controller
    
        } // end of did select row function
    
    } // end class