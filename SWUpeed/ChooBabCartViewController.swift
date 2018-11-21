
//
//  CartViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 12..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit
import MessageUI

class ChooBabCartViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var loginStatus: Bool = false
    
    
    var detailVC: ChooBabCartTableViewController?
    var cartCount = 0
    @IBOutlet weak var cartTab: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let count = detailVC?.menus.count{
            cartCount = count
        }
        cartTab.badgeValue = String(format: "%d", cartCount)
        
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(loginStatusGetter), name: NSNotification.Name("loginStatus") , object: nil)
        
    }
    @objc func loginStatusGetter(noti:Notification) {
        if let a = noti.object as? Bool{
            loginStatus = a
        }
        print("dd")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let count = detailVC?.menus.count{
            cartCount = count
        }
        cartTab.badgeValue = String(format: "%d", cartCount)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        detailVC?.menus.removeAll()
        detailVC?.totalPrice = 0
        detailVC?.tableView.reloadData()
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        var message = ""
        var storeCheck: [String:Bool] = [:]
        
        // 로그인이면
        if loginStatus == true {
            if let menus = detailVC?.menus{
                if menus.count > 0 {
                    var count = 0
                    for i in 0...menus.count-1{
                        let menu = menus[i]
                        if storeCheck[menu.storeName!] == nil{
                            if i != 0{
                                message += "\n"
                            }
                            
                            message += menu.storeName!
                            message += "\n"
                            storeCheck[menu.storeName!] = true
                            count = 0
                        }
                        count += 1
                        message += String(count) + ". "
                        message += menu.menuName!
                        message += " (" + Array(menu.size!.keys)[0] + ")" + "\n"
                        if menu.options!.count > 0{
                            message += "   (추가) "
                            
                            for k in 0...menu.options!.count-1{
                                message += Array(menu.options!.keys)[k]
                                if k != menu.options!.count-1{
                                    message += ", "
                                }
                            }
                        }
                        message += "\n"
                    }
                    
                    let alertController = UIAlertController(title: "SwuPeed", message: "전체 주문할까요?", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let DestructiveAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                        print("취소")
                    }
                    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        print("확인")
                        if MFMessageComposeViewController.canSendText() == true{
                            let recipients:[String] = ["01012345678"]
                            let messageController = MFMessageComposeViewController()
                            messageController.messageComposeDelegate  = self // implement delegate if you want
                            messageController.recipients = recipients
                            messageController.body = message
                            self.present(messageController, animated: true, completion: nil)
                        }
                    }
                    alertController.addAction(DestructiveAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                    
                else {
                    let alertController = UIAlertController(title: "경고", message: "장바구니가 비어있습니다.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        print("확인")
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        // 로그인이 안되있으면
        else {
            let alertController = UIAlertController(title: "경고", message: "먼저 로그인을 해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("확인")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        print(message)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSendMessage"{
            let dest = segue.destination as! ChooBabCartTableViewController
            dest.preVC = self
            detailVC = dest
        }
    }
}
