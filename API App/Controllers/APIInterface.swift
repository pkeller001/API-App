//
//  APIInterface.swift
//  API App
//
//  Created by Pat Keller on 11/19/21.
//
    
import Foundation
import UIKit

let defaults = UserDefaults.standard
let dictionaryKey = "myDictionary"

var b:Int = 0
var c:Int = 0
let group = DispatchGroup()
//var lastRetrieved: Date = Date()


func fetchData() {
    let fullDate = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    let today = formatter.string(from: fullDate)
    let last = defaults.string(forKey: "dateLastRetrieved")
    if last == nil {
        defaults.set(today, forKey: "dateLastRetrieved")
    }

    if today == last {
        // Code here to set myArray using coredata
    }
    
    group.enter()
    if let url = URL(string: K.baseURL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(APIarrayMap.self, from: safeData)
                        for i in 1...(results.entries.count) {
                            b = i - 1
                            let item = APIentry(apiName: results.entries[b].API, apiDesc: results.entries[b].Description, keyReqd: results.entries[b].Auth, httpsreqd: results.entries[b].HTTPS, corsreqd: results.entries[b].Cors, siteURL: results.entries[b].Link, apiCategory: results.entries[b].Category)
                            myArray.append(item)
                        }
                        //save myArray to coredata
                        createArrays()
                        defaults.set(today, forKey: "dateLastRetrieved")
                        print(today)
                        group.leave()
                    } catch {
                        print("Error decoding JSON \(error)")
                    }
                }
            } else {
                print("Error retrieving data from API - \(error!)")
            }
        }
        task.resume()
    }
}
// Update to use coredata
func createArrays() {
    for item in myArray {
        catArray.append(item.apiCategory)
        catArray = catArray.removingDuplicates()
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
