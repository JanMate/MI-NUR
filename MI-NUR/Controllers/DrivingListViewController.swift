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
    
    var dateFormat = DateFormatter()
        
    var vehicleIndex = 0
    var typeIndex = 0
    
    var distance = 0
    var duration = 0
    var cost = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dateFormat.dateFormat = "dd.MM.yyyy HH:mm"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
//        startDateText.isEnabled = false
//        endDateText.isEnabled = false
        selectedCarText.isEnabled = false
        driveTypeText.isEnabled = false
        tableView.refreshControl = UIRefreshControl()
        tableView.register(NativeCell.self, forCellReuseIdentifier: NativeCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
        startDateText.text = dateFormat.string(from: Date())
        endDateText.text = dateFormat.string(from: Date())
        driveTypeText.text = "All drives"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if DataService.vehicles.count > 0 {
            selectedCarText.text = DataService.vehicles[vehicleIndex].toString()
            distance = 0
            duration = 0
            cost = 0
            for drive in DataService.vehicles[vehicleIndex].drives {
                if typeIndex == 1 && drive.isBusiness {
                    distance += drive.distance
                    duration += drive.duration
                    cost += Int(round(Double(drive.distance / 100) * Double(DataService.vehicles[vehicleIndex].consuption) * 31.0))
                }
                if typeIndex == 2 && !drive.isBusiness {
                    distance += drive.distance
                    duration += drive.duration
                    cost += Int(round(Double(drive.distance / 100) * Double(DataService.vehicles[vehicleIndex].consuption) * 31.0))
                }
                if typeIndex == 0 {
                    distance += drive.distance
                    duration += drive.duration
                    cost += Int(round(Double(drive.distance / 100) * Double(DataService.vehicles[vehicleIndex].consuption) * 31.0))
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NativeCell.reuseIdentifier, for: indexPath) as! NativeCell
                
        cell.drive = DataService.vehicles[vehicleIndex].drives[(DataService.vehicles[vehicleIndex].drives.count - 1) - indexPath.row]
        
        return cell
    }
    
    @objc
    private func refreshTriggered(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TypeDriveViewController {
            let vc = segue.destination as? TypeDriveViewController
            vc?.mainController = self
            vc?.typeIndex = typeIndex
        }
    }
        
    @IBAction func didTappedVehicleTextBox(_ sender: Any) {
        if selectedCarText.text == "" {
            self.navigationController?.pushViewController(storyboard?.instantiateViewController(withIdentifier: "NewVehicleViewController") ?? NewVehicleViewController(), animated: true)
        } else {
            self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "VehicleViewController") ?? VehicleViewController(), sender: Any?.self)
        }
    }
    
    @IBAction func didTappedTypeDriveTextBox(_ sender: Any) {
        self.navigationController?.showDetailViewController(storyboard?.instantiateViewController(withIdentifier: "TypeDriveViewController") ?? TypeDriveViewController(), sender: Any?.self)
    }
}
final class NativeCell: UITableViewCell {
    static let reuseIdentifier = "NativeCell"
    
    var drive: Drive? {
        didSet {
            textLabel?.text = drive?.title()
            detailTextLabel?.text = drive?.subTitle()
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
