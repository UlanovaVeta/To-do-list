//
//  CheckboxButton.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 26.10.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import UIKit

class CheckboxButton: UIButton {
        
    //MARK: - Properties
    
    let imageChecked = UIImage(named: "CheckboxChecked.jpg")! as UIImage
    let imageUnchecked = UIImage(named: "CheckboxUnchecked.jpg")! as UIImage
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(imageChecked, for: .normal)
            } else {
                self.setImage(imageUnchecked, for: .normal)
            }
        }
    }
    
    //MARK: - Functions
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
}

