//
//  MainListInfo.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 19.11.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import Foundation

class MainListInfo: Codable {
    //MARK: - Properties
    
    var name: String
    var checked: Bool
    var onAction: (() -> Void)?
    
    //MARK: - Enumeration
    
    enum CodingKeys: String, CodingKey {
        case name
        case checked
    }
    
    //MARK: - Initializations
    
    init(name: String, checked: Bool) {
        self.name = name
        self.checked = checked
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name = try values.decode(String.self, forKey: .name)
        let checked = try values.decode(Bool.self, forKey: .checked)
        self.init(name: name, checked: checked)
    }
    
}
