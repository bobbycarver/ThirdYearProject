//
//  Users.swift
//  
//
//  Created by Bobby Carver on 07/03/2016.
//
//

import Foundation
import CoreData

class Users: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var dob: NSDate
    @NSManaged var email: String
    @NSManaged var make: String
    @NSManaged var model: String
    @NSManaged var name: String
    @NSManaged var numberplate: String
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var contact: String

}
