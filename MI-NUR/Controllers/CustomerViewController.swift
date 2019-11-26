//
//  CustomerViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 26/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var customerIndex = 0    
    var mainController: ManualDriveViewController?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pickerView.selectRow(customerIndex, inComponent: 0, animated: true)
    }
    
    @IBAction func didTappedOkButton(_ sender: Any) {
        mainController?.customerIndex = customerIndex
        dismiss(animated: true) {
            if DataService.customers.count > 0 {
                self.mainController?.customerIndex = self.pickerView.selectedRow(inComponent: 0)
                self.mainController?.customerName.text = DataService.customers[self.pickerView.selectedRow(inComponent: 0)].toString()
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.customers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return DataService.customers[row].toString()
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        customerIndex = row
    }
    
}
