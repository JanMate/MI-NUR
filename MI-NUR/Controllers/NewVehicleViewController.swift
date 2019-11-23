//
//  NewVehicleViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 23/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class NewVehicleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var liters: UIPickerView!
    
    var litersValue = Array(1...30)
    var deciLitersValue = Array(0...9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liters.delegate = self
        liters.selectRow(4, inComponent: 0, animated: true)
        liters.selectRow(5, inComponent: 1, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return litersValue.count
        } else {
            return deciLitersValue.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String("\(litersValue[row]),")
        } else {
            return String(deciLitersValue[row])
        }
    }
    
    @IBAction func didSaveButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
