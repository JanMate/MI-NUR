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
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.presentLoginController()
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
