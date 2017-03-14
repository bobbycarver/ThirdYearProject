//
//  setting.swift
//  CarCamera
//
//  Created by Bobby Carver on 23/03/2016.
//  Copyright (c) 2016 Bobby Carver. All rights reserved.
//

import UIKit


class setting {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    
    
    init?(name: String, photo: UIImage?) {
        
        self.name = name
        self.photo = photo
        
        if name.isEmpty {
            return nil
        }
        
    }
    
}
