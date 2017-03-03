//
//  ProphetMoveController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/24.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class ProphetMoveController: UIViewController {
    
    @IBOutlet weak var verificationNumber: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
    
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        if NightManage.shareNightManage.hasChecked == false {
            let str = verificationNumber.text
            if let number = Int(str!) {
                if number <= RoleConfiguration.roleConfigurationManager.fixRoleArray.count && number > 0 {
                    if NightManage.shareNightManage.deadNumbers.index(of: str!) == nil {
                        let confirmNumber = RoleConfiguration.roleConfigurationManager.fixRoleArray[number]
                        let standOrFall = RoleConfiguration.judgeRole(name: confirmNumber)
                        var message: String
                        
                        if standOrFall {
                            message = "好人"
                        } else {
                            message = "狼人"
                        }
                        let alert = CorrectAlertController.alertWith(title: "这个人身份是",
                                                                     message:message,
                                                                     andHandle:{ (action) in
                                                                        NightManage.shareNightManage.hasChecked = true
                                                                        self.confirmButton.isEnabled = false
                                                                        NotificationCenter.default.post(name: Notification.Name("rightBarButtonFalse"), object: nil)
                        })
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = CorrectAlertController.correctAlertWith(title: "这名玩家已死亡")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        verificationNumber.resignFirstResponder()
    }
    
    
    
    
}
