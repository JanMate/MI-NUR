//
//  UpdateProfileViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var jobPosition: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated: true)
        firstname.text = DataService.user.firstname
        lastname.text = DataService.user.lastname
        jobPosition.text = DataService.user.jobPosition
        company.text = DataService.user.companyName
        email.text = DataService.user.email
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        DataService.updateUser(user: User(firstname: firstname.text!, lastname: lastname.text!, jobPosition: jobPosition.text!, companyName: company.text!, email: email.text!, password: ""))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
