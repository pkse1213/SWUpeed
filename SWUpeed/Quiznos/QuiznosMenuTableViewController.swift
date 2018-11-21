//
//  QuiznosMenuTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 24..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class QuiznosMenuTableViewController: UITableViewController {

    @IBOutlet weak var sandwichORCoffeeSegment: UISegmentedControl!
    @IBOutlet weak var sandwichSegment: UISegmentedControl!
    @IBOutlet weak var drinkSegment: UISegmentedControl!
    
    var select = 0
    
    let sandwichSizePrice: [[String]] = [["7,700", "9,700", "11,700"], ["6,200", "8,200", "10200"],
                                         ["6,200", "8,200", "10,200"], ["4,500", "6,500", "8,500"],
                                         ["5,500", "7,500", "9,500"], ]
    
    let steak: [String] = ["제스티 그릴드 스테이크", "더블 치즈 스테이크", "치폴레 스테이크"]
    let chicken: [String] = ["치킨 까르보나라", "치킨 베이컨 랜치", "허니 머스타드 치킨", "크레이지 하사 치킨" ]
    let turkey: [String] = ["치폴레 터키", "터키 랜치 스위스" ]
    let value: [String] = ["햄 & 치즈", "치폴레 튜나"]
    let deli: [String] = ["트레디셔널", "이탈리안", "더블 베이컨 비엘티", "허니 리코타 치즈 & 베지"]
    
    
    
    let coffee: [String:String] = ["아메리카노":"2,500원", "에스프레소":"2,500원", "카페라떼":"3,000원", "카푸치노":"3,000원",
                                   "카페모카":"3,500원", "바닐라라떼":"3,500원", "카라멜라떼": "3,500원", "카라멜마끼아또":"3,500원"]
    let beverage: [String:String] = ["핫초코/아이스초코":"3,000원", "허브티":"2,500원", "에이드":"3,000원", "우유":"2,000원",
                                     "펩시콜라":"1,100원", "사이다":"1,100원", "마운틴듀":"1,100원", "미린다(오렌지)":"1,100원" ]
    
    var drinkMenu: [[String:String]] = []
    var sandwichMenu: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sandwichMenu.append(steak)
        sandwichMenu.append(chicken)
        sandwichMenu.append(turkey)
        sandwichMenu.append(value)
        sandwichMenu.append(deli)
        
        drinkMenu.append(coffee)
        drinkMenu.append(beverage)
        
        drinkSegment.isHidden = true
        
    }
    
    @IBAction func categoryChoose(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            select = 0
            drinkSegment.isHidden = true
            sandwichSegment.isHidden = false
        }
        else {
            select = 1
            sandwichSegment.isHidden = true
            drinkSegment.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    @IBAction func sandwichMenuChoose(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSandwichOrder"{
            let dest = segue.destination as! QuiznosOrderViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)!
            
            for i in 0...4{
                if sandwichSegment.selectedSegmentIndex == i{
                    dest.menuName = sandwichMenu[i][indexPath.row]
                    dest.SizePrice = sandwichSizePrice[i]
                }
            }
            print(dest.SizePrice)
        }
        
        if segue.identifier == "ToDrinkOrder"{
            let dest = segue.destination as! QuiznosDrinkViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)!
            for i in 0...1{
                if drinkSegment.selectedSegmentIndex == i{
                    dest.menuName = Array(drinkMenu[i].keys)[indexPath.row]
                    dest.iceOrHot = [Array(drinkMenu[i].values)[indexPath.row],
                                     Array(drinkMenu[i].values)[indexPath.row]]
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 샌드위치 눌렀을 때
        if select == 0 {
            return 2
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 샌드위치 눌렀을 때
        if select == 0 {
            var row = 0
            if section == 1 {
                for i in 0...sandwichMenu.count-1{
                    if sandwichSegment.selectedSegmentIndex == i{
                        row = sandwichMenu[i].count
                    }
                }
                return row
            }
            else {
                return 1
            }
        }
        // 드링크 눌렀을 때
        else {
            var row = 0
            for i in 0...drinkMenu.count-1{
                if drinkSegment.selectedSegmentIndex == i{
                    row = drinkMenu[i].count
                }
            }
            return row
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SandwichMenu Cell", for: indexPath)
        
        // 샌드위치 눌렀을 때
        if select == 0 {
            let selectIndex = self.sandwichSegment.selectedSegmentIndex
            
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "SizePrice Cell", for: indexPath)
                let priceArray = sandwichSizePrice[selectIndex]
                cell.textLabel?.text = "R: " + priceArray[0] + " / " +
                    "M: " + priceArray[1] + " / " +
                    "L: " + priceArray[2]
            }
            else if indexPath.section == 1 {
                
                cell.textLabel?.text = sandwichMenu[selectIndex][indexPath.row]
            }
        }
        // 드링크 눌렀을 때
        else {
            let selectIndex = self.drinkSegment.selectedSegmentIndex
            cell = tableView.dequeueReusableCell(withIdentifier: "DrinkMenu Cell", for: indexPath)
            
            cell.textLabel?.text = Array(drinkMenu[selectIndex].keys)[indexPath.row]
            cell.detailTextLabel?.text = Array(drinkMenu[selectIndex].values)[indexPath.row]
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
