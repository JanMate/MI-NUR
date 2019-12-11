//
//  ManualDriveViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ManualDriveViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
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
    var vehicleIndex = 0
    var customerIndex = 0
    
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
        carName.delegate = self
        customerName.isEnabled = false
        customerName.delegate = self
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
            carName.text = DataService.vehicles[vehicleIndex].toString()
            setStateBefore(value: DataService.vehicles[vehicleIndex].currentState)
            setStateAfter(value: stateBefore + distance)
        }
        if DataService.customers.count > 0 {
            customerName.text = DataService.customers[customerIndex].toString()
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
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CustomerViewController {
            let vc = segue.destination as? CustomerViewController
            vc?.customerIndex = customerIndex
            vc?.mainController = self
        }
        if segue.destination is VehicleViewController {
            let vc = segue.destination as? VehicleViewController
            vc?.vehicleIndex = vehicleIndex
            vc?.mainController = self
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == carName {
            self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "VehicleViewController") ?? VehicleViewController(), sender: Any?.self)
        }
        if textField == customerName {
            self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "CustomerViewController") ?? CustomerViewController(), sender: Any?.self)
        }
    }
    
    @IBAction func didTappedVehicleSelectButton(_ sender: Any) {
        if carName.text == "" {
            self.navigationController?.pushViewController(storyboard?.instantiateViewController(withIdentifier: "NewVehicleViewController") ?? NewVehicleViewController(), animated: true)
        } else {
            self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "VehicleViewController") ?? VehicleViewController(), sender: Any?.self)
        }
    }
    
    @IBAction func didTappedCustomerSelectButton(_ sender: Any) {
        if customerName.text == "" && customerChoice.isEnabled {
            self.navigationController?.pushViewController(storyboard?.instantiateViewController(withIdentifier: "NewCustomerViewController") ?? NewCustomerViewController(), animated: true)
        } else if customerName.text != "" && customerChoice.isEnabled {
            self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "CustomerViewController") ?? CustomerViewController(), sender: Any?.self)
        }
    }
    
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
