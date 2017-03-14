//
//  car.swift
//  CarCamera
//
//  Created by Bobby Carver on 24/03/2016.
//  Copyright (c) 2016 Bobby Carver. All rights reserved.
//

import UIKit

class mycar {
    // properties
    
    var heading : String
    var info : String
    
    
    init?(heading: String, info: String){
        
        self.heading = heading
        self.info = info
        
        if heading.isEmpty || info.isEmpty {
            return nil
        }
    }
    
}

