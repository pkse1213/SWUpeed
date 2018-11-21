

//
//  MyPageTableViewController.swift
//  guru3
//
//  Created by dm13 on 2018. 1. 24..
//  Copyright © 2018년 Jeongwon Na. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController {
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var loginStatusButton: UIButton!
    @IBOutlet weak var logoutStatusButton: UIButton!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var status:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile.isEnabled = false
        loginStatusButton.isHidden = false
        logoutStatusButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if status == true {
            profile.isEnabled = true
            loginStatusButton.isHidden = true
            logoutStatusButton.isHidden = false
        }
        else{
            profile.isEnabled = false
            loginStatusButton.isHidden = false
            logoutStatusButton.isHidden = true
        }
//        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
//
//        if(!isUserLoggedIn){
//            self.performSegue(withIdentifier: "loginView", sender: self)
//        }
        
        if status == true{
            loginStatusButton.titleLabel?.text = "로그아웃"
            if let userNameStored = UserDefaults.standard.string(forKey: "userName"){
                loginStatusLabel.text = userNameStored + "님 안녕하세요."
            }
            if let userNicknameStored = UserDefaults.standard.string(forKey: "userNickname"){
                nickname.text = userNicknameStored
            }
            if let userIdStored = UserDefaults.standard.string(forKey: "userId"){
                id.text = "(" + userIdStored + ")"
            }
            /*let fileManager = FileManager.default
             let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
             if fileManager.fileExists(atPath: imagePath){
             imageView.image = UIImage(contentsOfFile: imagePath)
             }else{
             print("Panic! No Image!")
             }*/
        }
        else
        {
            loginStatusButton.titleLabel?.text = "로그인"
            loginStatusLabel.text = "로그인 상태가 아닙니다."
            nickname.text = "닉네임"
            id.text = "(학번)"
        }
    }
    
    @IBAction func loginstatus(_ sender: UIButton) {
        if status == true{
            status = false
            loginStatusButton.titleLabel?.text = "로그인"
            loginStatusLabel.text = "로그인 상태가 아닙니다."
            nickname.text = "닉네임"
            id.text = "(학번)"
            
            loginStatusButton.isHidden = false
            logoutStatusButton.isHidden = true
            NotificationCenter.default.post(name: Notification.Name("loginStatus"), object: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginView" {
            let destVC = segue.destination as! LoginViewController
            destVC.preVC = self
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 2{
            if status == true{
                let alertController = UIAlertController(title: "계정 탈퇴", message: "확인을 누르면 SwuPeed에서 탈퇴됩니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                let DestructiveAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                    print("취소")
                }
                
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("확인")
                    self.status = false
                    UserDefaults.standard.set(nil, forKey:"userId")
                    UserDefaults.standard.set(nil, forKey:"userPassword")
                    UserDefaults.standard.set(nil, forKey:"userName")
                    UserDefaults.standard.set(nil, forKey:"userNickname")
                    UserDefaults.standard.synchronize()
                    self.viewDidAppear(true)
                }
                alertController.addAction(DestructiveAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                let alertController = UIAlertController(title: "경고", message: "로그인이 필요합니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("확인")
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
