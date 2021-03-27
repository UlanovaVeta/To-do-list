//
//  TableViewCell2.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 23.10.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import UIKit

class ListInfoCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
