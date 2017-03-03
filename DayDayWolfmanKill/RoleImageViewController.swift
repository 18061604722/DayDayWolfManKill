//
//  RoleImageViewController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/3/2.
//  Copyright © 2017年 yyj. All rights reserved.
//

import Foundation
import UIKit

class RoleImageViewController: UIViewController {
    
    @IBOutlet weak var roleImageView: UIImageView!
    
    var imageName: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.roleImageView.image = UIImage.init(named: imageName + ".jpeg")
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
