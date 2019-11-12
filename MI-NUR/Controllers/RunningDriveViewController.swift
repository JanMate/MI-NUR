//
//  RunningDriveViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class RunningDriveViewController: UIViewController {
    @IBOutlet weak var cancelDriveButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func didTappedCancelDriveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
