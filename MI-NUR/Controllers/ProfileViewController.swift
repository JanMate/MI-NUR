//
//  ProfileViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 11/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTappedLogoutButton(_ sender: Any) {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.presentLoginController()
    }
    
}
