//
//  profile.swift
//  CarCamera
//
//  Created by Bobby Carver on 23/03/2016.
//  Copyright (c) 2016 Bobby Carver. All rights reserved.
//

import UIKit

class myprofile {
    
    //Properties:
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

