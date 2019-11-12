//
//  ManualDriveViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ManualDriveViewController: UIViewController {
    
    @IBOutlet weak var saveDriveButton: UIButton!
    
    @IBOutlet weak var cancelDriveButton: UIButton!
    
    @IBOutlet weak var privateBusinessSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        //privateBusinessSwitch.onTintColor = .systemBlue
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        //self.navigationController?.pushViewController((UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrivingListViewController") as? DrivingListViewController)!, animated: true)
        //self.tabBarController?.selectedIndex = 1
        
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
       
    }
    
}
