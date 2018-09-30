//
//  TableViewCell.swift
//  Vegeee
//
//  Created by Nasir Ali on 11/09/2018.
//  Copyright © 2018 Nasir Ali. All rights reserved.
//

import UIKit
import Firebase

class CustomItemCell: UITableViewCell {

    

    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
