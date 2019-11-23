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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
