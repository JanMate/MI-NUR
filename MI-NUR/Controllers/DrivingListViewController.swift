//
//  DrivingListViewController.swift
//  MI-NUR
//
//  Created by Jan Matějka on 12/11/2019.
//  Copyright © 2019 Jan Matějka. All rights reserved.
//

import UIKit

class DrivingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateText: UITextField!
    @IBOutlet weak var selectedCarText: UITextField!
    @IBOutlet weak var driveTypeText: UITextField!
    
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var durationText: UILabel!
    @IBOutlet weak var costText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var vehicleIndex = 0
    
    var distance = 0
    var duration = 0
    var cost = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        startDateText.isEnabled = false
        endDateText.isEnabled = false
        selectedCarText.isEnabled = false
        driveTypeText.isEnabled = false
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if DataService.vehicles.count > 0 {
            selectedCarText.text = "\(DataService.vehicles[DataService.vehicles.count - 1].manufacture) \(DataService.vehicles[DataService.vehicles.count - 1].model), \(DataService.vehicles[DataService.vehicles.count - 1].color), \(DataService.vehicles[DataService.vehicles.count - 1].year)"
            vehicleIndex = DataService.vehicles.count - 1
            distance = 0
            duration = 0
            cost = 0
            for drive in DataService.vehicles[DataService.vehicles.count - 1].drives {
                distance += drive.distance
                duration += drive.duration
                cost += Int(round(Double(drive.distance / 100) * Double(DataService.vehicles[DataService.vehicles.count - 1].consuption) * 31.0))
            }
            distanceText.text = "\(String(distance)) km"
            durationText.text = "\(String(duration / 60)):\(String(duration % 60))"
            costText.text = "\(String(cost)) Kč"
        }
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.vehicles.count > 0 ? DataService.vehicles[vehicleIndex].drives.count : 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        cell.textLabel?.text = DataService.vehicles[vehicleIndex].drives[indexPath.row].toString()

        return cell
    }
    
    @objc
    private func refreshTriggered(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.endRefreshing()
        }
    }
}
