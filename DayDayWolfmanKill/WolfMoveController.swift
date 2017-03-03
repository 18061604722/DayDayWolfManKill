//
//  WolfMoveController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/24.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class WolfMoveController: UIViewController {
    
    
    @IBOutlet weak var killNumber: UITextField!
    
    override func viewDidLoad() {
        killNumber.keyboardType = UIKeyboardType.phonePad
    }
    
    @IBAction func confirmKill(_ sender: UIButton) {
        let str = killNumber.text
        if let number = Int(str!) {
            if number <= RoleConfiguration.roleConfigurationManager.fixRoleArray.count && number > 0 {
                if NightManage.shareNightManage.deadNumbers.index(of: str!) == nil {
                    NightManage.shareNightManage.todayNumber.append(killNumber.text!)
                    sender.isEnabled = false
                    NotificationCenter.default.post(name: Notification.Name("rightBarButtonFalse"), object: nil)
                } else {
                    let alert = CorrectAlertController.correctAlertWith(title: "这名玩家已死亡")
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = CorrectAlertController.correctAlertWith(title: "请输入一个正确的数字")
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = CorrectAlertController.correctAlertWith(title: "请输入一个正确的数字")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        killNumber.resignFirstResponder()
    }
    
}
