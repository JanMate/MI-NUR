//
//  RegistrationViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 11/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTappedRegisterButton(_ sender: UIButton) {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.presentTabBarController()
    }
    
}
