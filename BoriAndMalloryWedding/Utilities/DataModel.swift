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
}
