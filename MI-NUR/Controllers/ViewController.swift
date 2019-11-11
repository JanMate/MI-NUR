//
//  ViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 06/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //weak var button: UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTappedButton(_ sender: UIButton) {
        print("Tapped")
    }
    
    @IBAction func didTappedLoginBtn(_ sender: Any) {
        (UIApplication.shared.delegate as? AppDelegate)?.presentTabBarController()
    }
        
}

