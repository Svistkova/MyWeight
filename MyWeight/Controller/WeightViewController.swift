//
//  ViewController.swift
//  MyWeight
//
//  Created by Marina Svistkova on 31.03.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    var date = ""
    var cellArrayFirst = [CellModel]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Weight.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightLabel.text! += getDate()
        
        weightTextField.delegate = self
        weightTextField.keyboardType = .decimalPad
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        if let weight = weightTextField.text?.doubleValue {
            
            switch weight {
            case 0.0:
                weightTextField.text = ""
                weightTextField.placeholder = "Вес должен быть более 0.1 кг."
            case 0.1...200.00:
                self.performSegue(withIdentifier: "goToResult", sender: self)
                cellArrayFirst.insert(CellModel(dateCell: date, weightCell: String(weight)), at: 0)
                self.saveItems()
                weightTextField.text = ""
            case 200.00...:
                weightTextField.text = ""
                weightTextField.placeholder = "Вес не должен быть более 200 кг."
            default:
                weightTextField.placeholder = "Укажите ваш вес"
                
            }
            
        }
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        date = formatter.string(from: Date())
        
        return date
    }
    
    
    @IBAction func GoToDataButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    //MARK:- TextField Delegate Methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
        
    }
        
    
    //MARK: - Model Manipulation Methods
    
    func saveItems () {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(cellArrayFirst)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding cellArrayFirst, \(error)")
        }
        //        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                cellArrayFirst = try decoder.decode([CellModel].self, from: data)
            } catch {
                print("Error decoding cellArrayFirst, \(error)")
            }
        }
    }
    
    
}


// Converts "comma" in Russian keypad into "dot" and makes it a legitimate Double
extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}


    // method to not allow to enter more than one decimal points, 2 decimal places and digits only

extension String {
  func isValidDouble(maxDecimalPlaces: Int) -> Bool {

    let formatter = NumberFormatter()
    formatter.allowsFloats = true
    let decimalSeparator = formatter.decimalSeparator ?? "."
    if formatter.number(from: self) != nil {
      let split = self.components(separatedBy: decimalSeparator)
      let digits = split.count == 2 ? split.last ?? "" : ""

      return digits.count <= maxDecimalPlaces
    }
    return false
  }
}
