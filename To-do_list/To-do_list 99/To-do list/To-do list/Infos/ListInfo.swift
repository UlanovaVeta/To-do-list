//
//  ListInfo.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 19.11.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import Foundation

class ListInfo: Codable {
    //MARK: - Properties
    
    var cellName: String
    var cellInfo: String
    
    //MARK: - Enumeration
    
    enum CodingKeys: String, CodingKey {
        case cellName
        case cellInfo
    }
    
    //MARK: - Initializations
    
    init(cellName: String, cellInfo: String) {
        self.cellName = cellName
        self.cellInfo = cellInfo
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let cellName = try values.decode(String.self, forKey: .cellName)
        let cellInfo = try values.decode(String.self, forKey: .cellInfo)
        self.init(cellName: cellName, cellInfo: cellInfo)
    }
    
}
