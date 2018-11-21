
//
//  CartTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 12..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//


//uialertview 또는 uiactionsheet
import UIKit
import NotificationCenter

class ChooBabCartTableViewController: UITableViewController {
    var preVC: ChooBabCartViewController?
    
    var menus: [Menu] = []
    var totalPrice = 0
    var store: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(addCartItem), name: NSNotification.Name("CartAdded") , object: nil)
        
        if menus.count > 2{
            menus.sort(by: { $0.storeName! < $1.storeName! })
        }
    }

    //장바구니 정보 받아와서 처리
    @objc func addCartItem(noti:Notification) {
        print("addcart!!")
        if let a = noti.object as? Menu{
            menus.append(a)
            totalPrice += a.totalPrice!
            if let b = store[a.storeName!]{
                store[a.storeName!] = b+1
            }
            else{
                store[a.storeName!] = 1
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else {
            let menu = menus[section-1]
            if let count = menu.options?.count{
                return count + 3
            }
            else {
                return 3
            }
        }
    }

    
    // cell삭제 클릭시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.row == 0 {

            let cell = self.tableView(tableView, cellForRowAt: indexPath)
            let nameLabel = cell.viewWithTag(1) as! UILabel
            let alertController = UIAlertController(title: nameLabel.text, message: "해당 상품을 장바구니에서 삭제할까요?", preferredStyle: UIAlertControllerStyle.alert)
            let DestructiveAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                print("취소")
            }
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("확인")
                self.totalPrice -= self.menus[indexPath.section-1].totalPrice!
                self.menus.remove(at: indexPath.section-1)
                self.tableView.reloadData()
            }
            alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let vc = preVC{
            vc.cartTab.badgeValue = String(format: "%d", menus.count)
        }
        
        var cell: UITableViewCell!
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Total Cell", for: indexPath)
            let totalPriceLabel = cell.viewWithTag(1) as! UILabel
            var a = Array(String(self.totalPrice))
            a = a.reversed()
            
            var b :[Character] = []
            for i in 0...a.count-1 {
                b.append(a[i])
                if (i+1) % 3 == 0{
                    b.append(",")
                }
            }
            b.reverse()
            
            var priceText = ""
            
            for i in 0...b.count-1 {
                priceText += String(b[i])
            }
            totalPriceLabel.text = String(priceText) + "원"
            tableView.rowHeight = 67
            
        }
        else {
            let menu = menus[indexPath.section-1]
            
            if indexPath.row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: "MenuName Cell", for: indexPath)
                let nameLabel = cell.viewWithTag(1) as! UILabel
                nameLabel.text = menu.storeName! + " " + menu.menuName!
                tableView.rowHeight = 30
                
            }
            else {
                if indexPath.row == 1{
                    cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath)
                    let nameLabel = cell.viewWithTag(1) as! UILabel
                    let priceLabel = cell.viewWithTag(2) as! UILabel
                    if let a = menu.size{
                        tableView.rowHeight = 30
                        nameLabel.text = Array(a.keys)[0]
                        priceLabel.text = Array(a.values)[0]
                        
                    }
                }
                else {
                    if let a = menu.options{
                        cell = tableView.dequeueReusableCell(withIdentifier: "Option Cell", for: indexPath)
                        let nameLabel = cell.viewWithTag(1) as! UILabel
                        let priceLabel = cell.viewWithTag(2) as! UILabel

                        if indexPath.row == a.count+2{
                            tableView.rowHeight = 30
                            cell = tableView.dequeueReusableCell(withIdentifier: "Price Cell", for: indexPath)
                            let nameLabel = cell.viewWithTag(1) as! UILabel
                            let priceLabel = cell.viewWithTag(2) as! UILabel
                            
                            nameLabel.text = "금액"
                            
                            var a = Array(String(menu.totalPrice!))
                            a = a.reversed()
                            
                            var b :[Character] = []
                            for i in 0...a.count-1 {
                                b.append(a[i])
                                if (i+1) % 3 == 0{
                                    b.append(",")
                                }
                            }
                            b.reverse()
                            
                            var priceText = ""
                            
                            for i in 0...b.count-1 {
                                priceText += String(b[i])
                            }
                            priceLabel.text = String(priceText) + "원"
                            
                        }
                        else {
                            tableView.rowHeight = 30
                            nameLabel.text = Array(a.keys)[indexPath.row-2]
                            priceLabel.text = Array(a.values)[indexPath.row-2]
                            
                        }
                    }
                }
            }
        }
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
