//
//  TarotDataModel.swift
//  Random
//
//  Created by T800 on 8/30/20.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct TarotDataModel:Decodable {
    var tarots: [TarotDetails]
}

struct TarotDetails:Decodable {
    var id: String?
    var name: String?
    var description: String?
}
