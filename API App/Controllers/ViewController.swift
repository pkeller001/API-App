//
//  ViewController.swift
//  API App
//
//  Created by Pat Keller on 11/19/21.
//
import Foundation
import UIKit

var myArray = [APIentry]()
var catArray = [String]()
var apiArray = [APIentry]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var categoryView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.delegate = self
        categoryView.dataSource = self
        fetchData()
        group.wait()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return catArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = categoryView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = catArray[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        let entry = catArray[indexPath.row]
        apiArray.removeAll()
        for item in myArray {
            if item.apiCategory == entry {
                apiArray.append(item)
            }
        }
        performSegue(withIdentifier: "sequeToAPI", sender: entry)
    }
    
} /* End of Top Class */

