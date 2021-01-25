//
//  SettingViewController.swift
//  I2SN
//
//  Created by 손상준 on 2021/01/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5
    }
    
    let timeInterval = [10, 30, 60]
    
    @IBAction func returnPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func assignBackground(){
        let background = UIImage(named: "background.jpg")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeInterval.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as? TimeCell else {
            return UITableViewCell()
        }
        
        cell.timeLabel.text = "\(timeInterval[indexPath.row])minutes"
        return cell
    }
}

class TimeCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
}