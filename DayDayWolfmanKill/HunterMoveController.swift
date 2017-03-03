//
//  HunterMoveController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/24.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class HunterMoveController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        
        if NightManage.shareNightManage.ableToShoot == true {
            statusLabel.text = "可以开枪"
        } else {
            statusLabel.text = "不可以开枪"
        }
        
        NotificationCenter.default.post(name: Notification.Name("rightBarButtonFalse"), object: nil)
    }
}
