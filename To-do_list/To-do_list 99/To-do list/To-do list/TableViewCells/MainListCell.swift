//
//  TableViewCell.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 23.10.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import UIKit

class MainListCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet var checkboxButton: CheckboxButton!
    @IBOutlet var checkboxLabel: UILabel!
    @IBOutlet var viewButton: UIButton!
    
    //MARK: - IBAction
    
    @IBAction func onButton(_ sender: Any) {
        mainListItem?.onAction?()
    }
    
    //MARK: - Property
    
    var mainListItem: MainListInfo? {
        didSet {
            guard let mainListItem = mainListItem else {return}
            checkboxLabel.text = mainListItem.name
        }
    }
    
    //MARK: - Functions
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
