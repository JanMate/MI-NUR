//
//  VehicleViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 26/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var vehicleIndex = 0
    var mainController: ManualDriveViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        pickerView.selectRow(vehicleIndex, inComponent: 0, animated: true)        
    }
    
    @IBAction func didTappedOkButton(_ sender: Any) {
        dismiss(animated: true) {
            if (DataService.vehicles.count > 0) {
                self.mainController?.vehicleIndex = self.pickerView.selectedRow(inComponent: 0)
                self.mainController?.carName.text = DataService.vehicles[self.pickerView.selectedRow(inComponent: 0)].toString()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return DataService.vehicles[row].toString()
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        vehicleIndex = row
    }
    
}
