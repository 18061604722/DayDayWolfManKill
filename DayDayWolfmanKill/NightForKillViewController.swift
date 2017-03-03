//
//  NightForKillViewController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/21.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

enum GameEndEnum: String {
    case manWin = "好人胜利"
    case wolfWin = "狼人胜利"
    case NOGG
}


class NightForKillViewController: UIViewController, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!

    var wolfMove: WolfMoveController!
    var switchMove: SwitchMoveController!
    var prophetMove: ProphetMoveController!
    var hunterMove: HunterMoveController!
    
    override func viewDidLoad() {
        pageViewController = self.childViewControllers.first as! UIPageViewController
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        wolfMove = storyboard?.instantiateViewController(withIdentifier: "wolfMoveID") as! WolfMoveController
        switchMove = storyboard?.instantiateViewController(withIdentifier: "switchMoveID") as! SwitchMoveController
        prophetMove = storyboard?.instantiateViewController(withIdentifier: "prophetMoveID") as! ProphetMoveController
        hunterMove = storyboard?.instantiateViewController(withIdentifier: "hunterMoveID") as! HunterMoveController
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        pageViewController.setViewControllers([wolfMove], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        setScrollDisable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeRightBarButtonStatus), name: NSNotification.Name(rawValue: "rightBarButtonFalse"), object: nil)
        
    }
    
    func changeRightBarButtonStatus() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    func setScrollDisable() {
        var scrollView = UIScrollView()
        for subview in pageViewController.view.subviews {
            if subview is UIScrollView {
                scrollView = subview as! UIScrollView
                
            }
        }
        scrollView.isScrollEnabled = false
        
    }
    
    @IBAction func closeYourEye(_ sender: Any) {
        
        let firstPage = pageViewController.viewControllers?.first
        if firstPage is WolfMoveController {
            pageViewController.setViewControllers([switchMove], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil);
            
        } else if firstPage is SwitchMoveController {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            pageViewController.setViewControllers([prophetMove], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            
        } else if firstPage is ProphetMoveController {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            pageViewController.setViewControllers([hunterMove], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            self.navigationItem.rightBarButtonItem?.title = "天亮了"
            
        } else if firstPage is HunterMoveController {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            NightManage.shareNightManage.deadNumbers += NightManage.shareNightManage.todayNumber
            NightManage.shareNightManage.hasChecked = false
            self.dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: Notification.Name("informationForNight"), object: nil)
            
            //deadNumberArray游戏结束判断
            switch gameEndEstimate() {
            case .manWin:
                let alert = CorrectAlertController.correctAlertWith(title: "好人胜利")
                self.present(alert, animated: true, completion: nil)
            case .wolfWin:
                let alert = CorrectAlertController.correctAlertWith(title: "狼人胜利")
                self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    
    func gameEndEstimate() -> GameEndEnum {
        
        var civilian = 0
        var wolf = 0
        var god = 0
        for str in NightManage.shareNightManage.deadNumbers {
            if RoleConfiguration.roleConfigurationManager.fixRoleArray[Int(str)!] == "平民" {
                civilian += 1
            } else if RoleConfiguration.roleConfigurationManager.fixRoleArray[Int(str)!] == "狼人" {
                wolf += 1
            } else {
                god += 1
            }
        }
        
        if civilian == 3 || god == 3 {
            return .wolfWin
        } else if wolf == 3 {
            return .manWin
        } else {
            return .NOGG
        }
    }
}

extension NightForKillViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is WolfMoveController {
            return switchMove
            
        } else if viewController is SwitchMoveController {
            return prophetMove
            
        } else if viewController is ProphetMoveController {
            return hunterMove
            
        } else {
            return nil
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController is SwitchMoveController {
            return wolfMove
            
        } else if viewController is ProphetMoveController {
            return switchMove
            
        } else if viewController is HunterMoveController {
            return prophetMove
            
        } else {
            return nil
            
        }
    }
}





