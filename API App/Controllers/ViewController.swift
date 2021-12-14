//
//  ViewController.swift
//  API App
//
//  Created by Pat Keller on 11/19/21.
//
import Foundation
import UIKit
import CoreData


var myArray = [CoreAPIentry]()
var catArray = [String]()
var apiArray = [CoreAPIentry]()
let group = DispatchGroup()
class ViewController: UITableViewController {
    

    @IBOutlet weak var categoryView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:   .userDomainMask).first
        print(dataFilePath!)
        categoryView.delegate = self
        categoryView.dataSource = self
        group.enter()
        fetchData()
        group.wait()
        self.createArrays()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = categoryView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = catArray[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        let entry = catArray[indexPath.row]
        apiArray.removeAll()
        for item in myArray {
            if item.cAPIcategory == entry {
                apiArray.append(item)
            }
        }
        //sort apiArray by cAPIname ignoring case
        apiArray.sort{
            $0.cAPIname!.caseInsensitiveCompare($1.cAPIname!) == .orderedAscending
        }
        performSegue(withIdentifier: "sequeToAPI", sender: entry)
    }
    
    //MARK: - Create array of categories from array of all API's
    func createArrays() {
        for item in myArray {
            catArray.append(item.cAPIcategory!)
            catArray = catArray.removingDuplicates()
            catArray.sort()
        }
    }

    
} /* End of Top Class */

//MARK: - Revoves duplicates from array
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
