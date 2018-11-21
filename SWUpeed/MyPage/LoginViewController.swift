//
//  LoginViewController.swift
//  guru3
//
//  Created by dm13 on 2018. 1. 24..
//  Copyright © 2018년 Jeongwon Na. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{
    var preVC: MyPageTableViewController?
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userIdtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func loginButton(_ sender: UIButton) {
        let userId = userIdtextField.text
        let userPassword = userPasswordTextField.text
        
        let userIdStored = UserDefaults.standard.string(forKey: "userId")
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        if(userIdStored == userId)
        {
            if(userPasswordStored == userPassword)
            {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
                print("로그인 완료")
                if let vc = preVC {
                    vc.status = true
                }
                NotificationCenter.default.post(name: Notification.Name("loginStatus"), object: true)
            }
            else
            {
                print("비밀번호가 틀립니다.")
                let myAlert = UIAlertController(title:"경고", message:"비밀번호가 틀립니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){ action in
                }
                
                myAlert.addAction(okAction)
                self.present(myAlert, animated:true, completion:nil)
                
            }
        }
        else
        {
            print("존재하지 않는 계정입니다.")
            let myAlert = UIAlertController(title:"경고", message:"존재하지 않는 계정입니다.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){ action in
            }
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
