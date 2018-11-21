
//
//  ViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 25..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabController = appDelegate.window?.rootViewController
        let tableVC = tabController?.childViewControllers[1] as! ChooBabCartViewController
        tableVC.cartTab.badgeValue = "0"
        
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
