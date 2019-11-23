//
//  ManualDriveViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ManualDriveViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var saveDriveButton: UIButton!
    @IBOutlet weak var cancelDriveButton: UIButton!
    @IBOutlet weak var privateBusinessSwitch: UISwitch!
    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var customerChoice: UIButton!
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var carName: UITextField!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var stateBeforeText: UITextField!
    @IBOutlet weak var stateAfterText: UITextField!
    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var toText: UITextField!
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateText: UITextField!
    
    var distance: Int = 0
    var stateBefore: Int = 0
    var stateAfter: Int = 0
    var from: String? = ""
    var to: String? = ""
    var dateFormat = DateFormatter()
    var start: String?
    var end: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dateFormat.dateFormat = "dd.MM.yyyy HH:mm"
        start = dateFormat.string(from: Date())
        end = dateFormat.string(from: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        carName.isEnabled = false
        customerName.isEnabled = false
        distancePicker.dataSource = self
        distancePicker.delegate = self
        setDistance(value: distance)
        setStateBefore(value: stateBefore)
        setStateAfter(value: stateBefore + distance)
        fromText.text = from
        toText.text = to
        startDateText.text = start
        endDateText.text = end
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didSwitchedPrivateBusinessSwitch(_ sender: Any) {
        if (privateBusinessSwitch.isOn){
            customerChoice.isEnabled = true
        } else {
            customerChoice.isEnabled = false
        }
    }
    
    let pickerValues = Array(0...1000)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        distance = pickerValues[row]
        distanceSlider.setValue(Float(distance) / 1000, animated: true)
        setStateAfter(value: stateBefore + distance)
    }

    @IBAction func didSliderValueChanged(_ sender: Any) {
        distance = Int(distanceSlider.value * 1000)
        distancePicker.selectRow(distance, inComponent: 0, animated: true)
        setStateAfter(value: stateBefore + Int(distanceSlider.value * 1000))
    }

    @IBAction func didStateBeforeChanged(_ sender: Any) {
        setStateBefore(value: Int(stateBeforeText.text!) ?? 0)
        setStateAfter(value: stateBefore + distance)
    }

    @IBAction func didStateAfterChanged(_ sender: Any) {
        setStateAfter(value: Int(stateAfterText.text!) ?? 0)
        setDistance(value: stateAfter - stateBefore)
    }
    
    func setDistance(value: Int) {
        distance = value
        distanceSlider.setValue(Float(distance) / 1000, animated: true)
        distancePicker.selectRow(distance, inComponent: 0, animated: true)
    }

    func setStateBefore(value: Int) {
        stateBefore = value
        stateBeforeText.text = String(value)
    }

    func setStateAfter(value: Int) {
        stateAfter = value
        stateAfterText.text = String(value)
    }
}
