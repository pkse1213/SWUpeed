
//
//  BeetleMenuTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 25..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class BeetleMenuTableViewController: UITableViewController {

    @IBOutlet weak var menuSegment : UISegmentedControl!
    
    var fruitJuiceMenu : [String: [String]] = ["바나나우유": ["            ", "2,700원"],
                                           "딸기": ["            ", "3,700원"],
                                           "딸기+바나나": ["            ", "3,700원"],
                                           "딸기+키위": ["            ", "3,700원"],
                                           "딸기+파인애플": ["", "3,700원"],
                                           "키위": ["            ", "3,700원"],
                                           "키위+바나나": ["            ", "3,700원"],
                                           "토마토": ["            ", "3,700원"],
                                           "토마토+딸기": ["            ", "3,700원"],
                                           "파인애플": ["            ", "3,700원"],
                                           "파인애플+키위": ["            ", "3,700원"],
                                           "파인애플+바나나": ["            ", "3,700원"],
                                           "청포도": ["            ", "4,900원"],
                                           "크림슨": ["            ", "4,900원"],
                                           "망고": ["            ", "4,900원"],
                                           "망고+바나나": ["            ", "4,900원"],
                                           "망고+딸기": ["            ", "4,900원"],
                                           "멜론": ["            ", "4,900원"],
                                           "멜론+바나나": ["            ", "4,900원"],
                                           "멜론+수박": ["            ", "4,900원"],
                                           "레몬": ["            ", "4,300원"],
                                           "파인애플+레몬": ["            ", "4,300원"],
                                           "수박+레몬": ["            ", "4,300원"],
                                           "청포도+레몬": ["            ", "4,900원"],
                                           "오렌지+레몬": ["            ", "4,900원"],
                                           "오렌지": ["            ", "4,300원"],
                                           "자몽": ["            ", "4,300원"],
                                           "자몽+오렌지": ["            ", "4,900원"],
                                           "오디": ["            ", "4,300원"],
                                           "복분자": ["            ", "4,300원"],
                                           "블루베리": ["            ", "4,300원"],
                                           "체리": ["            ", "4,500원"],
                                           "인삼": ["            ", "4,500원"],
                                           "용과": ["            ", "4,500원"],
                                           "아보카도": ["            ", "4,500원"],
                                           "두리안": ["            ", "4,500원"],
                                           "당근+사과": ["            ", "4,300원"],
                                           "당근+오렌지": ["            ", "4,300원"],
                                           "당근+파인애플": ["            ", "4,300원"] ]
    
    var coffeeMenu : [String: [String]] = ["아메리카노": ["1,800원", "2,000원"],
                                           "카페라떼": ["2,300원", "2,500원"],
                                           "카푸치노": ["2,300원", "            "],
                                           "바닐라라떼": ["2,800원", "3,000원"],
                                           "카라멜마끼아또": ["3,000원", "3,500원"],
                                           "카페모카": ["2,800원", "3,200원"],
                                           "화이트모카": ["2,800원", "3,200원"],
                                           "연유라떼": ["3,000원", "3,500원"],
                                           "녹차라떼": ["2,300원", "2,300원"],
                                           "홍차라떼": ["2,300원", "2,300원"],
                                           "고구마라떼": ["2,300원", "2,300원"],
                                           "초코라떼": ["2,300원", "3,000원"],
                                           "민트초코라떼": ["2,800원", "3,200원"],
                                           "화이트 민트초코라떼": ["2,800원", "3,200원"], ]
    
    var milkJuiceMenu : [String: [String]] = ["녹차라떼": ["2,300원", "2,300원"],
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
    var menus: [[String: [String]]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuSegment.selectedSegmentIndex = 0
        menus.removeAll()
        menus.append(fruitJuiceMenu)
        menus.append(milkJuiceMenu)
        menus.append(coffeeMenu)
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
        var row = 0
        for i in 0...2{
            if menuSegment.selectedSegmentIndex == i{
                row = menus[i].count
            }
        }
        return row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Beetle Cell", for: indexPath)
        for i in 0...2{
            if menuSegment.selectedSegmentIndex == i{
                if i == 0{
                    cell.textLabel?.text = Array(menus[i].keys)[indexPath.row]
                    cell.detailTextLabel?.text = "ice " + Array(menus[i].values)[indexPath.row][1]
                }
                else {
                    cell.textLabel?.text = Array(menus[i].keys)[indexPath.row]
                    cell.detailTextLabel?.text = "hot " + Array(menus[i].values)[indexPath.row][0] +
                        "   ice " + Array(menus[i].values)[indexPath.row][1]
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOrder"{
            let dest = segue.destination as! BeetleOrderViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)!
            for i in 0...2{
                if menuSegment.selectedSegmentIndex == i{
                    dest.menuName = Array(menus[i].keys)[indexPath.row]
                    dest.iceOrHot = Array(menus[i].values)[indexPath.row]
                }
            }
        }
    }

}
