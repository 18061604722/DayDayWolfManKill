//
//  RoleConfiguration.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/22.
//  Copyright © 2017年 yyj. All rights reserved.
//

import Foundation

struct RoleConfiguration {
    
    static var roleConfigurationManager = RoleConfiguration()
    //[身份:人数]
    var peopleRole:[String] = []
    
    //乱序数组
    var fixRoleArray:[String] = []
    
    //从Plist获取数据
    private func getDataFromPlist() -> NSDictionary? {
        let rolePlist = Bundle.main.path(forResource: "RolePlist", ofType: "plist")
        let roleData = NSDictionary.init(contentsOfFile: rolePlist!)
        return roleData
    }
    
    //获取TV显示数组
    mutating func getConfiguration(number: String?) -> [String] {
        let roleData = getDataFromPlist()
        switch number! {
        case "9","10","11","12":
            let configurationDictionary: NSDictionary = roleData?[number!] as! NSDictionary
            StringConcatenation(configuration: configurationDictionary)
            return peopleRole
        default:
            return ["推荐人数9~12"]
        }
    }
    
    //拼接字符串
    mutating private func StringConcatenation(configuration: NSDictionary) {
        let keyArray:[String] = configuration.allKeys as! [String]
        for key in keyArray {
            if let value = configuration.object(forKey: key) {
                if (value as! NSNumber) != 0 {
                    let rowString: String = key + ":" + (value as! NSNumber).stringValue
                    peopleRole.append(rowString)
                }
            }
        }
    }
    
    //具体配置数组
    mutating func allRoleDetails(number: String) -> [String] {
        let allRole = getDataFromPlist()
        let configurationDictionary: NSDictionary = allRole?[number] as! NSDictionary
        var detailsArray:[String] = []
        
        for (key, value) in configurationDictionary {
            for _ in 0..<(value as! NSNumber).intValue {
                detailsArray.append(key as! String)
            }
            
        }
        
        DisturbOrder(detailsArray: &detailsArray)
        
        return RoleConfiguration.roleConfigurationManager.fixRoleArray
    }
    
    //乱序
    mutating func DisturbOrder(detailsArray: inout [String]) {
        let playerNumberInt = UInt32(detailsArray.count)
        
        for x in 0..<playerNumberInt {
            var index:UInt32 = 0
            if x == playerNumberInt - 1 {
                RoleConfiguration.roleConfigurationManager.fixRoleArray.append(detailsArray[0])
                print("\(detailsArray[0])")
            } else {
                index = arc4random() % (playerNumberInt - 1 - x)
                RoleConfiguration.roleConfigurationManager.fixRoleArray.append(detailsArray[Int(index)])
                print("\(detailsArray[Int(index)])")
            }
            detailsArray.remove(at: Int(index))
        }
        
        print("\(RoleConfiguration.roleConfigurationManager.fixRoleArray)")
    }
    
    //身份判定
    static func judgeRole(name: String) -> Bool {
        if name == "狼人" || name == "白狼王" {
            return false
        }
        return true
    }
    
}

    
    
    
    
    

