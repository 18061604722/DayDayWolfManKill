//
//  ViewController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/2/20.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var peopleNumber: UITextField!
    @IBOutlet weak var roleConfiguration: UITableView!
    
    var datasourceArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleNumber.delegate = self
        peopleNumber.keyboardType = UIKeyboardType.phonePad
        
        roleConfiguration.bounces = false
        roleConfiguration.contentSize = roleConfiguration.bounds.size
        self.setDataSource(text: peopleNumber.text)
        
    }
    
    @IBAction func startGameTime(_ sender: UIButton) {
        
        if peopleNumber.text! != "" {
            switch peopleNumber.text! {
            case "9","10","11","12":
                self.performSegue(withIdentifier: "startGame", sender: nil)
            default:
                datasourceArray = ["请输入9~12之内的人数"]
                roleConfiguration.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameStartViewController
        vc.playerNumber = peopleNumber.text!
    }
    
    func setDataSource(text: String?) {
        
        var manage = RoleConfiguration()
        datasourceArray = manage.getConfiguration(number: text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.setDataSource(text: textField.text)
        roleConfiguration.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        peopleNumber.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datasourceArray[indexPath.row]
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

