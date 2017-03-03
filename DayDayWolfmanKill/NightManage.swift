//
//  NightManage.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/24.
//  Copyright © 2017年 yyj. All rights reserved.
//

import Foundation

class NightManage {
    
    static let shareNightManage = NightManage()
    //死亡人员数组
    var deadNumbers: [String] = []
    
    //今夜死亡人员号码
    var todayNumber: [String] = []
    
    //女巫行动使能
    var switchSave: Bool = true
    var switchPosion: Bool = true
    
    //预言家能否验人
    var hasChecked: Bool = false
    
    //猎人开枪状态
    var ableToShoot: Bool = true
    
    
    
    
    
    
    
    
}
