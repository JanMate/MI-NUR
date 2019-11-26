//
//  NewCustomerViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 25/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class NewCustomerViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zip: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTappedAddButton(_ sender: Any) {
        DataService.addCustomer(customer: Customer(name: name.text!, street: street.text!, city: city.text!, zipCode: zip.text!))
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
