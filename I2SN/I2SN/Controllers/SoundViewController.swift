//
//  SoundViewController.swift
//  I2SN
//
//  Created by 권준원 on 2021/02/04.
//

import UIKit
import FirebaseAnalytics

class SoundViewController: UIViewController {
    
    @IBOutlet weak var selectTableView: UITableView!
    
    private let soundArray = ["삐삐", "삐삐삐삐", "빠른 삐삐삐삐", "삐빅", "삐비동", "꼬꼬덱", "자명종 소리", "학교 벨소리", "긴 전화벨 소리", "비상밸 소리", "방사능 위험"]
    // default sound "삐삐"
    private var sound = "삐삐"
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setTableViewLayout()
        selectTableView.dataSource = self
        selectTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // default sound "삐삐"
        self.sound = userDefaults.string(forKey: DataKeys.alarmSound) != "" ? userDefaults.string(forKey: DataKeys.alarmSound)! : "삐삐"
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
    
    func setTableViewLayout() {
        selectTableView.layer.cornerRadius = 5
        selectTableView.rowHeight = 44
    }
}

// MARK: - UITableViewDataSource
extension SoundViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectTableView.dequeueReusableCell(withIdentifier: "SelectCell", for: indexPath)
        cell.textLabel?.text = soundArray[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SoundViewController: UITableViewDelegate {
    // 셀에 있는 모든 체크마크를 지움
    func resetAccessoryType(){
        for row in 0..<self.selectTableView.numberOfRows(inSection: 0){
            let cell = self.selectTableView.cellForRow(at: IndexPath(row: row, section: 0))
            cell?.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resetAccessoryType()
        guard let cell = selectTableView.cellForRow(at: indexPath) as? SelectCell else { return }
        // 선택된 셀에 체크마크 표시
        cell.accessoryType = .checkmark
        cell.selectionStyle = .none
        sound = soundArray[indexPath.row]
        userDefaults.set(sound, forKey: DataKeys.alarmSound)
        // GA - custom event 추가
        Analytics.logEvent("set_alarm_sound", parameters: ["alarmSound": sound as String])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if soundArray.firstIndex(of: sound) == indexPath.row {
            selectTableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
    }
}