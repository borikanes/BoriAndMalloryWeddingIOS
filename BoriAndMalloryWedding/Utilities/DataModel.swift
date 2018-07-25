//
//  DataModel.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/16/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import Foundation
import UIKit

private var json = """
[
    {
        "name": "Mallory McDonald",
        "table": "3"
    },
    {
        "name": "Mallory Oludemi",
        "table": "2"
    },
    {
        "name": "Dad McDonald",
        "table": "1"
    }
]
""".data(using: .utf8)!

struct SeatInfo: Decodable {
    var name: String
    var table: String
}

func getSeatInformationArray(jsonData: Data = json) -> [SeatInfo]? {
    let decoder = JSONDecoder()
    var seatInfoArray: [SeatInfo]?
    do {
        seatInfoArray = try decoder.decode([SeatInfo].self, from: jsonData)
    } catch {
        print("Error Parsing array")
        seatInfoArray = nil
    }

    return seatInfoArray
}

struct FoodInfo {
    var name: String
    var imageName: String
    var textColor: UIColor
    var indicatorImageName: String
}

struct FoodDescriptionInfo: Decodable {
    // swiftlint:disable identifier_name
    var puff_puff: String
    var jollof: String
    var efo_elegusi_clean: String
    var chin_chin: String
    var nigerian_fried_rice_clean: String
    var meat_pie: String
    var salmon: String
    var italian_chicken: String
    var yam_porridge_clean: String
    var stewed_chicken: String
    var vegetable_stew_clean: String
    var moin_moin: String
    var default_image: String
}
