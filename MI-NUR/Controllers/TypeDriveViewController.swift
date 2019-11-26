//
//  TypeDriveViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 26/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class TypeDriveViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let list = ["All drives", "Business drives", "Private drives"]
    
    var typeIndex = 0
    var mainController: DrivingListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    @IBAction func didTappedOkButton(_ sender: Any) {
        dismiss(animated: true) {
            self.mainController?.typeIndex = self.pickerView.selectedRow(inComponent: 0)
            self.mainController?.driveTypeText.text = self.list[self.pickerView.selectedRow(inComponent: 0)]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeIndex = row
    }
    
}
