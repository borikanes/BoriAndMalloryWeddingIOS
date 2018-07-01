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
    print(file.absoluteString)
    do {
        try json.write(to: file, options: .atomic)
    } catch {
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
}

func saveModifiedTimeToUserDefaultDB(time: String) {
    let defaults = UserDefaults.standard
    defaults.set(time, forKey: "LastModifiedTime")
}

func getTimeFromAPI(withCompletion completion: @escaping (String?) -> Void ) {
    // Call API here and save to UserDefault
    let timeEndpoint = "https://styf7r70gj.execute-api.us-east-1.amazonaws.com/prod/time"
    guard let timeUrl = URL(string: timeEndpoint) else {
        print("Error: cannot create URL")
        completion(nil)
        return
    }
    print("Get TIME called")
    let urlRequest = URLRequest(url: timeUrl)
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        guard error == nil else {
            print("error calling time API")
            print(error!)
            completion(nil)
            return
        }
        guard let responseData = data else {
            print("Error: did not receive data")
            completion(nil)
            return
        }

        let responseString = String(data: responseData, encoding: .utf8)!
        print("RESPONSE --- \(responseString)")
        completion(responseString)
    }
    task.resume()
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

func doesJsonFileExistInFileSystem() -> Bool {
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let fileURL = URL(fileURLWithPath: filePath)
    let fileComponentPath = fileURL.appendingPathComponent(filename)

    return FileManager.default.fileExists(atPath: fileComponentPath.path)
}

func makeNetworkCallForSeatingData(withCompletion completion: @escaping (Data?) -> Void) {
    let timeEndpoint = "https://styf7r70gj.execute-api.us-east-1.amazonaws.com/prod/seating"
    guard let timeUrl = URL(string: timeEndpoint) else {
        print("Error: cannot create URL")
        completion(nil)
        return
    }
    let urlRequest = URLRequest(url: timeUrl)
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        guard error == nil else {
            print("error calling time API")
            print(error!)
            completion(nil)
            return
        }
        guard let responseData = data else {
            print("Error: did not receive data")
            completion(nil)
            return
        }

        let responseString = String(data: responseData, encoding: .utf8)!
        print("RESPONSE --- \(responseString)")
        completion(responseData)
    }
    task.resume()

}
