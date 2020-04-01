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
    
    
    var cellArray: [CellModel] = []
    //adding some temporary hardcoded items
    let item1 = CellModel(dateCell: "01/01/01", weightCell: "55.88")
    let item2 = CellModel(dateCell: "02/02/02", weightCell: "55.77")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellArray.append(item1)
        cellArray.append(item2)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeightCell", for: indexPath) as! StatisticsCell
        cell.dateRecorded.text = cellArray[indexPath.row].dateCell
        cell.weightRecorded.text = cellArray[indexPath.row].weightCell
        
        tableView.reloadData()
        
        return cell
    }
    
    
}
