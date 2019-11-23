//
//  DrivingListViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class DrivingListViewController: UIViewController {
    
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateText: UITextField!
    @IBOutlet weak var selectedCarText: UITextField!
    @IBOutlet weak var driveTypeText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        startDateText.isEnabled = false
        endDateText.isEnabled = false
        selectedCarText.isEnabled = false
        driveTypeText.isEnabled = false
    }
}
