//
//  ViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 06/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //weak var button: UIButton
    @IBOutlet weak var fbLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTappedButton(_ sender: UIButton) {
        print("Tapped")
    }
    
    @IBAction func didTappedLoginButton(_ sender: Any) {
      (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.presentTabBarController()
    }
        
}

