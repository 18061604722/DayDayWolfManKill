//
//  GameStartViewController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/21.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class GameStartViewController: UIViewController {
    
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var rightStack: UIStackView!
    @IBOutlet weak var rightStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var exileNumber: UITextField!
    
    
    var playerNumber: String = ""
    var fixRoleArray:[String] = []
    var shootNumber: Int?
    lazy var roleImageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoleImageViewController") as! RoleImageViewController
    lazy var customPresentController: CustomPresentationController = CustomPresentationController(presentedViewController: self.roleImageViewController, presenting: self)
    
    override func viewWillAppear(_ animated: Bool) {
        
        for number in NightManage.shareNightManage.deadNumbers {
            for imageView in leftStack.subviews {
                if imageView is UIImageView && (imageView.tag == 100 + (Int(number)!)){
                    (imageView as! UIImageView).image = UIImage.init(named: "红叉.jpeg")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        self.setPeopleNumber()
        self.getRoleDetailsArray()
        
        roleImageViewController.transitioningDelegate = customPresentController
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertNightInformation), name: NSNotification.Name(rawValue: "informationForNight"), object: nil)

    }
    
    func alertNightInformation() {
        
        if NightManage.shareNightManage.todayNumber.count == 0 {
            let alert = CorrectAlertController.correctAlertWith(title: "今天平安夜")
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = CorrectAlertController.correctAlertWith(title: "昨天xx死亡,没有遗言")
            self.present(alert, animated: true, completion: nil)
            NightManage.shareNightManage.todayNumber.removeAll()
        }
    }
    
    func setPeopleNumber() {
        let rightNumber = Int(playerNumber)! - 6
        let rightHeight = rightNumber*70
        rightStackHeight.constant = CGFloat(rightHeight)
        
        for index in 0..<rightNumber-3 {
            let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            imageView.image = UIImage.init(named: "卡背")
            imageView.contentMode = .scaleToFill
            imageView.tag = 110 + index
            rightStack.addArrangedSubview(imageView)
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 20))
            label.contentMode = .center
            label.text = "\(index+10)"
            rightStack.addArrangedSubview(label)
            
        }
        
        for imageView in leftStack.subviews {
            if imageView is UIImageView {
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(GameStartViewController.showRole))
                tap.numberOfTapsRequired = 1
                tap.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(tap)
                imageView.isUserInteractionEnabled = true
                
            }
        }
        
        for imageView in rightStack.subviews {
            if imageView is UIImageView {
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(GameStartViewController.showRole))
                tap.numberOfTapsRequired = 1
                tap.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(tap)
                imageView.isUserInteractionEnabled = true
                
            }
        }
    }
    
    func getRoleDetailsArray() {
        fixRoleArray = RoleConfiguration.roleConfigurationManager.allRoleDetails(number: playerNumber)
        
    }
    
    func showRole(tap: UITapGestureRecognizer) {
        print("\(tap.view?.tag)")
        print("\(fixRoleArray[(tap.view?.tag)! - 101])")
        roleImageViewController.imageName = fixRoleArray[(tap.view?.tag)! - 101]
        self.present(roleImageViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func endGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func itIsTimeForKill(_ sender: Any) {
        performSegue(withIdentifier: "nightForKill", sender: nil)
        
    }

    @IBAction func exile(_ sender: Any) {
        let tagStr = "10" + exileNumber.text!
        if let tag = Int(tagStr) {
            let imageView = self.leftStack.viewWithTag(tag) as! UIImageView
            imageView.image = UIImage.init(named: "红叉.jpeg")
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        exileNumber.resignFirstResponder()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("rightBarButtonFalse"), object: nil)
        
    }
}

// Mark: 转场动画
//extension GameStartViewController: UIViewControllerTransitioningDelegate {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        return EasyAnimator()
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        return EasyAnimator()
//    }
//}












