//
//  settingsTableViewCell.swift
//  
//
//  Created by Bobby Carver on 23/03/2016.
//
//

import UIKit //import UIKit

class settingsTableViewCell: UITableViewCell {
    
    //properties
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var photoimgview: UIImageView!
    @IBOutlet weak var carlbl: UILabel!
    @IBOutlet weak var cartb: UITextField!
    @IBOutlet weak var profiletb: UITextField!
    @IBOutlet weak var profilelbl: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

}
