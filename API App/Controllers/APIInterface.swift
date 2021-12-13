//
//  APIInterface.swift
//  API App
//
//  Created by Pat Keller on 11/19/21.
//
    
import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let dictionaryKey = "myDictionary"
var b:Int = 0
var c:Int = 0
var l = [LastSaved]()
var last = ""
var today = ""
var refreshingData = "n"


func fetchData() {
    let fullDate = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    today = formatter.string(from: fullDate)
    let f2: NSFetchRequest<LastSaved> = LastSaved.fetchRequest() /* setup to get last saved date from CD*/
    do {
        l = try context.fetch(f2)  /*retieve last saved date*/
        if l.count == 0 {          /* anything there?*/
            last = " "           /* no, set last saved date as blank */
        } else {
            last = l[0].lastDate!   /*If there as data in CD, save the last saved date as l*/
        }
    } catch {
        print("Error retrieving coredata \(error)")
    }
    if today != last {              /* was data last saved today ?*/
        refreshCoreData()           /* no, got get new data, build myArray & save to CD */
    } else {                       /* yes....*/
        let request: NSFetchRequest<CoreAPIentry> = CoreAPIentry.fetchRequest() /* setup to read from CD */
        do {
            myArray = try context.fetch(request)        /* get myArray data from CD */
            group.leave()
        } catch {
            print("Error retrieving coredata \(error)")
        }
    }
    }

//MARK: - Call API to download data...
func refreshCoreData() {
    
    refreshingData = "y"
    if let url = URL(string: K.baseURL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                saveJSON(data)
            } else {
                print("Error retrieving data from API - \(error!)")
            }
        }
        task.resume()
    }
}

//MARK: - Decode JSON and save items to core data...
func saveJSON(_ data: Data?) {
    let decoder = JSONDecoder()
    if let safeData = data {
        do {
            let results = try decoder.decode(APIarrayMap.self, from: safeData)
                for i in 0..<(results.entries.count) {
                    let coreItem = NSEntityDescription.insertNewObject(forEntityName: "CoreAPIentry", into: context)
                    coreItem.setValue(results.entries[i].Category, forKey: "cAPIcategory")
                    coreItem.setValue(results.entries[i].API, forKey: "cAPIname")
                    coreItem.setValue(results.entries[i].Description, forKey: "cAPIdesc")
                    coreItem.setValue(results.entries[i].Auth, forKey: "cKeyReqd")
                    coreItem.setValue(results.entries[i].HTTPS, forKey: "cHTTPSreqd")
                    coreItem.setValue(results.entries[i].Cors, forKey: "cCORSreqd")
                    coreItem.setValue(results.entries[i].Link, forKey: "cAPIurl")
                    myArray.append(coreItem as! CoreAPIentry)
                }
                let d = LastSaved(context: context)
                d.lastDate = today
                saveData()
                group.leave()
        } catch {
            print("Error decoding JSON \(error)")
        }
    }
}

//MARK: - Save data to coredata...
func saveData() {
    do {
        try context.save()
    } catch {
        print("Error saving to coredata \(error)")
    }
}


