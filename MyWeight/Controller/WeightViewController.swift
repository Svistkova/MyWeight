//
//  ViewController.swift
//  MyWeight
//
//  Created by Marina Svistkova on 31.03.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weightLabel.text! += getDate()
        
        weightTextField.delegate = self
      
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)

    }
    
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        let weight = weightTextField.text!
        
        if weight != "" {
            print(weight)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        date = formatter.string(from: Date())
        return date
    }
    
    
    @objc func tableViewTapped() {
        weightTextField.endEditing(true)
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
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 3
    }
    
    
}
