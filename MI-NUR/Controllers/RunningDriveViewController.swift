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
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    
    var spentTime = 0
    var distanceValue = 0
    var startTimeFormat = DateFormatter()
        
    var timer = Timer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeDuration), userInfo: nil, repeats: true)
        duration.text = "0:00"
        distance.text = "0 km"
        startTimeFormat.dateFormat = "dd.MM.yyyy HH:mm"
        startTimeLabel.text = startTimeFormat.string(from: Date())
        from.text = "Prague, Czechia"
        to.text = "Prague, Czechia"
    }
    
    @IBAction func didTappedCancelDriveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeDuration), userInfo: nil, repeats: true)
    }
    
    @objc func changeDuration()
    {
        spentTime += 1
        if (spentTime % 60) < 10 {
            duration.text = "\(spentTime / 60):0\(spentTime % 60)"
        } else {
            duration.text = "\(spentTime / 60):\(spentTime % 60)"
        }
        distanceValue += 2
        distance.text = "\(distanceValue) km"
        if distanceValue > 30 {
            to.text = "Mirošovice, Czechia"
        }
        if distanceValue > 60 {
            to.text = "Trhový Štěpánov, Czechia"
        }
        if distanceValue > 100 {
            to.text = "Humpolec, Czechia"
        }
        if distanceValue > 130 {
            to.text = "Jihlava, Czechia"
        }
        if distanceValue > 155 {
            to.text = "Velké Meziříčí, Czechia"
        }
        if distanceValue > 200 {
            to.text = "Brno, Czechia"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ManualDriveViewController
        {
            let vc = segue.destination as? ManualDriveViewController
            vc?.distance = distanceValue
            vc?.from = from.text
            vc?.to = to.text
            vc?.start = startTimeLabel.text
            vc?.end = startTimeFormat.string(from: Date())
        }
    }
    
    
}
