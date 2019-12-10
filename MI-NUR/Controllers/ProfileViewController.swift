//
//  ProfileViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 11/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var jobPosition: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullname.text = "\(DataService.user.firstname) \(DataService.user.lastname)"
        jobPosition.text = "\(DataService.user.jobPosition)"
        company.text = "\(DataService.user.companyName)"
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fullname.text = "\(DataService.user.firstname) \(DataService.user.lastname)"
        jobPosition.text = "\(DataService.user.jobPosition)"
        company.text = "\(DataService.user.companyName)"
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    @IBAction func didTappedLogoutButton(_ sender: Any) {
       
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) -> Void in
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.presentLoginController()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.vehicles.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        cell.textLabel?.text = DataService.vehicles[indexPath.row].toString()

        return cell
    }
    
    @objc
    private func refreshTriggered(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.endRefreshing()
        }
    }
    
}
