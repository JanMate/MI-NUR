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
    @IBOutlet weak var manufacture: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var licensePlate: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var year: UITextField!
    
    
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
        DataService.addVehicle(vehicle: Vehicle(manufacture: manufacture.text!, model: model.text!, licensePlate: licensePlate.text!, color: color.text!, initState: Int(state.text!) ?? 0, consuption: Float(liters.selectedRow(inComponent: 0) + (liters.selectedRow(inComponent: 1) / 10)), year: Int(year.text!) ?? 0))
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
