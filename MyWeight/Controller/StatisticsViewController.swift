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
    var firstScreenData = WeightViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60.0
        
        
        if let dates = UserDefaults.standard.string(forKey: firstScreenData.dateSet), let weights = UserDefaults.standard.string(forKey: firstScreenData.weightSet) {
            let singleCellData = CellModel(dateCell: dates, weightCell: weights)
            cellArray.append(singleCellData)
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeightCell", for: indexPath) as! StatisticsCell
        
        cell.dateRecorded.text = cellArray[indexPath.row].dateCell
        print(cellArray[indexPath.row].dateCell)
        print(cell.dateRecorded.text!)
        
        
        
        cell.weightRecorded.text = cellArray[indexPath.row].weightCell
        
        print(cellArray[indexPath.row].weightCell)
        print(cell.weightRecorded.text!)

        
        //        tableView.reloadData()
        
        return cell
        
        
    }
    
    
}
