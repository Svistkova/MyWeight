//
//  Statistics.swift
//  MyWeight
//
//  Created by Marina Svistkova on 31.03.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import Foundation
import UIKit

class StatisticsViewController: UITableViewController {
    
    var weightScreenData = WeightViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60.0
        tableView.reloadData()
        weightScreenData.loadItems()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightScreenData.cellArrayFirst.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeightCell", for: indexPath) as! StatisticsCell
        
        cell.dateRecorded.text = weightScreenData.cellArrayFirst[indexPath.row].dateCell
        cell.weightRecorded.text = weightScreenData.cellArrayFirst[indexPath.row].weightCell
        
        return cell
        
    }
    
}
