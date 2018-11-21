
//
//  OrderViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 12..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class ChooBabOrderViewController: UIViewController {

    @IBOutlet weak var orderView: UIView!
    
    var detailVC: ChooBabOrderTableViewController?
   
    var menuName: String = ""
    var sizeDic: [String:String] = [:]
    var optionDic: [String:String] = [:]
    var price: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = menuName
    }
    
    @IBAction func cartAdd(_ sender: UIButton) {
        if let dVC = detailVC {
            self.price = dVC.price
            self.sizeDic = dVC.sizeDic
            self.optionDic = dVC.optionDic
        }
        //-------------------------------------------------------------
        print(menuName)
        print(sizeDic)
        print(optionDic)
        //-------------------------------------------------------------
        
        let menu = Menu(storeName:"[츄밥]" ,menuName: menuName , size: sizeDic, options: optionDic, totalPrice: price)
        tabBarController?.selectedIndex = 1
        
        //리스트 던져줘야함
        NotificationCenter.default.post(name: Notification.Name("CartAdded"), object: menu)
        
        self.navigationController?.popViewController(animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOptionDetail"{
            let dest = segue.destination as! ChooBabOrderTableViewController
            
            detailVC = dest
        }
    }
}
