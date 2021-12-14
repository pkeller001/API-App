//
//  APIViewController.swift
//  API App
//
//  Created by Pat Keller on 11/21/21.
//

import Foundation
import UIKit

class APIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navItem: UINavigationItem!

    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        apiTableView.delegate = self
        apiTableView.dataSource = self
        apiTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        navItem.title = "API's for " + apiArray[0].cAPIcategory!
        return apiArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = apiTableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! APIcellDetails
        cell.textLabel?.numberOfLines = 0
        let name = apiArray[indexPath.item].cAPIname
        let desc = apiArray[indexPath.item].cAPIdesc
        cell.name?.text = name
        cell.desc?.text = desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        let entry = apiArray[indexPath.row].cAPIurl
        url = entry!
        performSegue(withIdentifier: "sequeToWeb", sender: entry)
        }
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryVC.entry = entryToBeSent
            }
        }
    } */
    
}
