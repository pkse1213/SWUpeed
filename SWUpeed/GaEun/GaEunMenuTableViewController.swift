
//
//  GaEunMenuTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 22..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class GaEunMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var menuSegment : UISegmentedControl!
    
    var coffeeMenu : [String: [String]] = ["에스프레소": ["1,800원", "            "],
                                           "아메리카노": ["1,800원", "2,000원"],
                                           "카페라떼": ["2,300원", "2,500원"],
                                           "카푸치노": ["2,300원", "            "],
                                           "바닐라라떼": ["2,800원", "3,000원"],
                                           "카라멜마끼아또": ["3,000원", "3,500원"],
                                           "카페모카": ["2,800원", "3,200원"],
                                           "화이트모카": ["2,800원", "3,200원"],
                                           "연유라떼": ["3,000원", "3,500원"],
                                           "아포가토": ["3,000원", "            "] ]
    
     var BeverageMenu : [String: [String]] = ["녹차라떼": ["2,300원", "2,300원"],
                                              "홍차라떼": ["2,300원", "2,300원"],
                                              "고구마라떼": ["2,300원", "2,300원"],
                                              "초코라떼": ["2,300원", "3,000원"],
                                              "민트초코라떼": ["2,800원", "3,200원"],
                                              "화이트 민트초코라떼": ["2,800원", "3,200원"],
                                              "오곡라떼": ["2,600원", "2,800원"],
                                              "아이스티": ["            ", "1,900원"],
                                              "핑크레몬에이드": ["            ", "2,200원"],
                                              "바나나우유": ["            ", "2,300원"],
                                              "플레인스무디": ["            ", "2,300원"],
                                              "과일스무디": ["            ", "2,300원"] ]
    
    var TeaMenu : [String: [String]] = ["카모마일 허브티": ["1,900원", "2,000원"],
                                        "페퍼민트 허브티": ["1,900원", "2,000원"],
                                        "자스민플라워 허브티": ["1,900원", "2,000원"],
                                        "레본글라스 허브티": ["1,900원", "2,000원"],
                                        "유자차": ["2,000원", "2,300원"],
                                        "레몬차": ["2,000원", "2,300원"],
                                        "자몽차": ["2,000원", "2,300원"],
                                        "생강차": ["2,000원", "2,300원"] ]
    var chooseMenu: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuSegment.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func chooseCategory(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuSegment.selectedSegmentIndex == 0{
             return coffeeMenu.count
        }
        else if menuSegment.selectedSegmentIndex == 1{
            return BeverageMenu.count
        }
        else {
            return TeaMenu.count
        }
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Gaeun Cell", for: indexPath)
        
        if menuSegment.selectedSegmentIndex == 0{
            cell.textLabel?.text = Array(coffeeMenu.keys)[indexPath.row]
            cell.detailTextLabel?.text = "hot " + Array(coffeeMenu.values)[indexPath.row][0] +
                "   ice " + Array(coffeeMenu.values)[indexPath.row][1]
        }
        else if menuSegment.selectedSegmentIndex == 1{
            cell.textLabel?.text = Array(BeverageMenu.keys)[indexPath.row]
            cell.detailTextLabel?.text = "hot " + Array(BeverageMenu.values)[indexPath.row][0] +
                "   ice " + Array(BeverageMenu.values)[indexPath.row][1]
        }
        else {
            cell.textLabel?.text = Array(TeaMenu.keys)[indexPath.row]
            cell.detailTextLabel?.text = "hot" + Array(TeaMenu.values)[indexPath.row][0] +
                "   ice " + Array(TeaMenu.values)[indexPath.row][1]
        }
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOrder"{
            let dest = segue.destination as! GaEunCoffeeOptionViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)!
            
            if menuSegment.selectedSegmentIndex == 0{
                dest.menuName = Array(coffeeMenu.keys)[indexPath.row]
                dest.iceOrHot = Array(coffeeMenu.values)[indexPath.row]
                
            }
            else if menuSegment.selectedSegmentIndex == 1{
                dest.menuName = Array(BeverageMenu.keys)[indexPath.row]
                dest.iceOrHot = Array(BeverageMenu.values)[indexPath.row]
            }
            else {
                dest.menuName = Array(TeaMenu.keys)[indexPath.row]
                dest.iceOrHot = Array(TeaMenu.values)[indexPath.row]
                
            }
        }
    }
}
