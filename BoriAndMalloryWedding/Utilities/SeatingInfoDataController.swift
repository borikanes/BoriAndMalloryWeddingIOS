//
//  SeatingInfoDataController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/20/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import Foundation

let filename = "data.json"

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

func writeToDisk(json: Data = json) {
    let file = getDocumentsDirectory().appendingPathComponent(filename)
    do {
        try json.write(to: file, options: .atomic)
    } catch {
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
}

func saveModifiedTimeToUserDefaultDB(time: String) {
    return
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getFile() -> String? {
    var jsonString: String? = nil
    do {
        jsonString = try String(contentsOf: getDocumentsDirectory().appendingPathComponent(filename), encoding: .utf8)
    } catch {
        // handle error
    }

    return jsonString
}

func getLatestSeatingData() {
    // Do all the magic of fetching data and saving to disk. May need call back so i know it's done?
    return
}
