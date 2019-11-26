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
    var vehicleIndex = (DataService.vehicles.count > 0 ? DataService.vehicles.count - 1 : 0)
    var customerIndex = (DataService.customers.count > 0 ? DataService.customers.count - 1 : 0)
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if DataService.vehicles.count > 0 {
            carName.text = "\(DataService.vehicles[DataService.vehicles.count - 1].toString())"
            setStateBefore(value: DataService.vehicles[DataService.vehicles.count - 1].currentState)
            setStateAfter(value: stateBefore + distance)
        }
        if DataService.customers.count > 0 {
        customerName.text = "\(DataService.customers[DataService.customers.count - 1].name), \(DataService.customers[DataService.customers.count - 1].street), \(DataService.customers[DataService.customers.count - 1].city)"
        }
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        let duration = round(dateFormat.date(from: endDateText.text!)! - dateFormat.date(from: startDateText.text!)!)
        DataService.addDrive(vehicleIndex: vehicleIndex, drive: Drive(startDate: startDateText.text!, endDate: endDateText.text!, duration: Int(duration / 60), vehicle: DataService.vehicles[vehicleIndex], isBusiness: privateBusinessSwitch.isOn, customer: (privateBusinessSwitch.isOn ? DataService.customers[customerIndex] : Customer(name: "", street: "", city: "", zipCode: "")), from: fromText.text!, to: toText.text!, distance: distance, stateBefore: stateBefore, stateAfter: stateAfter))
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didSwitchedPrivateBusinessSwitch(_ sender: Any) {
        if (privateBusinessSwitch.isOn){
            customerChoice.isEnabled = true
            customerName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            customerChoice.isEnabled = false
            customerName.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
