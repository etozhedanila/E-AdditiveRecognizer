//
//  Additive.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 30/09/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import Foundation

class Additive {
    var code: String!
    var name: String!
    var danger: String!
    var description: String!
    
    init?(code: String) {
        self.code = code
        if let additive = eCodes[code] {
            if let name = additive["name"],
                let danger = additive["danger"],
                let description = additive["description"] {
                self.name = name
                self.danger = danger
                self.description = description
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
        
    }
    
}


