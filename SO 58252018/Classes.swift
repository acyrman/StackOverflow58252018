//
//  Classes.swift
//  SO 58252018
//
//  Created by acyrman on 10/5/19.
//  Copyright © 2019 iCyrman. All rights reserved.
//

import Foundation

struct Class: Codable {
    let prop_id: String
    let prop_location: String
    let prop_price: String
    enum CodingKeys : String, CodingKey {
        case prop_id = "prop_id"
        case prop_location = "prop_location"
        case prop_price = "prop_price"
    }
}
