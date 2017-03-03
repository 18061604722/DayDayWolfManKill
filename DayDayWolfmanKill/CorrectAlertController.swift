//
//  CorrectAlertController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/28.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class CorrectAlertController: NSObject {
    
     class func correctAlertWith(title: String) -> UIAlertController{
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    class func alertWith(title: String, message: String?, andHandle: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: andHandle)
        alert.addAction(action)
        return alert
    }
    
}

extension CorrectAlertController: UITabBarDelegate {
    func asd() {
        print("1")
    }
}


extension CorrectAlertController {
    func aaa() {
        print("2")
    }
}
