//
//  SwitchMoveController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/24.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class SwitchMoveController: UIViewController {
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var poisonNumber: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var posionButton: UIButton!
    
    override func viewDidLoad() {
        if NightManage.shareNightManage.switchSave == false {
            saveButton.isEnabled = false
        }
        
        if NightManage.shareNightManage.switchPosion == false {
            posionButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let number = NightManage.shareNightManage.todayNumber.first
        informationLabel.text = String.init(format: informationLabel.text!, number!)
    }
    
    @IBAction func save(_ sender: Any) {
        if NightManage.shareNightManage.switchSave == true {
            let alert = UIAlertController.init(title: "你救了这名玩家", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { action in
                NightManage.shareNightManage.todayNumber.removeFirst()
                NightManage.shareNightManage.switchSave = false
                self.actionOver()
                NotificationCenter.default.post(name: Notification.Name("rightBarButtonFalse"), object: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func posionToKill(_ sender: Any) {
        if NightManage.shareNightManage.switchPosion == true {
            let str = poisonNumber.text
            if let number = Int(str!) {
                if number <= RoleConfiguration.roleConfigurationManager.fixRoleArray.count && number > 0 {
                    if NightManage.shareNightManage.deadNumbers.index(of: str!) == nil {
                        let alert = CorrectAlertController.alertWith(title: String.init(format: "你毒死了%@号玩家", str!), message: nil, andHandle: { (action) in
                            NightManage.shareNightManage.todayNumber.append(str!)
                            NightManage.shareNightManage.switchPosion = false
                            if RoleConfiguration.roleConfigurationManager.fixRoleArray.index(of: "猎人") == Int(str!)! {
                                NightManage.shareNightManage.ableToShoot = false
                            }
                            self.actionOver()
                            NotificationCenter.default.post(name: Notification.Name("rightBarButtonFalse"), object: nil)
                        })
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = CorrectAlertController.correctAlertWith(title: "这位玩家已经死亡")
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    self.present(CorrectAlertController.correctAlertWith(title: "请输入一个正确的数字"), animated: true, completion: nil)
                }
            } else {
                self.present(CorrectAlertController.correctAlertWith(title: "请输入一个数字"), animated: true, completion: nil)
            }
        }
    }
    
    func actionOver() {
        saveButton.isEnabled = false
        posionButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        poisonNumber.resignFirstResponder()
    }
    
}
