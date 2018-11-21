
//
//  QuiznosOrderTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 24..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class QuiznosOrderTableViewController: UITableViewController {

    @IBOutlet var sizeCell: [UITableViewCell]!
    @IBOutlet var optionCell: [UITableViewCell]!
    // 가격 라벨
    @IBOutlet weak var priceLabel: UILabel!
    
    var price: Int = 0
    var image: [UIImage] = []
    var sizePrice: [Int] = [0, 0, 0]
    var optionPrice: [Int] = [300, 300, 300 ,300, 500, 500, 600]
    
    var preSizePrice: [String] = ["","",""]
    
    var sizeDic: [String:String] = [:]
    var optionDic: [String:String] = [:]
    var priceText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage.init(named: "check.png")
        let image2 = UIImage.init(named: "unCheck.png")
        
        image.append(image1!)
        image.append(image2!)
        
        let priceText1 = sizeCell[0].viewWithTag(2) as! UILabel
        let priceText2 = sizeCell[1].viewWithTag(2) as! UILabel
        let priceText3 = sizeCell[2].viewWithTag(2) as! UILabel
        
        priceText1.text = preSizePrice[0] + "원"
        priceText2.text = preSizePrice[1] + "원"
        priceText3.text = preSizePrice[2] + "원"
        
        for i in 0...2{
            var a: String = preSizePrice[i]
            a = a.replacingOccurrences(of: ",", with: "")
            print(a)
            sizePrice[i] = Int(a)!
        }
        price = sizePrice[0]
        priceLabel.text = preSizePrice[0] + "원"
        sizeDic["R(13cm)"] = preSizePrice[0] + "원"
        
        print(sizeDic)
        print(optionDic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return sizeCell.count
        }
        else if section == 3{
            return 1
        }
        else{
            return optionCell.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        priceText = ""
        
        // 사이즈를 눌렀을 때
        if indexPath.section == 2{
            for i in 0...sizeCell.count-1 {
                if indexPath.row == i {
                    let imageView = sizeCell[i].viewWithTag(3) as! UIImageView
                    imageView.image = image[0]
                    
                    sizeDic.removeAll()
                    
                    let sizeText = sizeCell[i].viewWithTag(1) as! UILabel
                    let sizePriceText = sizeCell[i].viewWithTag(2) as! UILabel
                    
                    sizeDic[sizeText.text!] = sizePriceText.text
                    
                    price = 0
                    price += sizePrice[i]
                    
                    // 옵션 선택된 값들 추가
                    for k in 0...optionCell.count-1 {
                        let cell = optionCell[k] as! OptionTableViewCell
                        if cell.isCheck() == true {
                            price += optionPrice[k]
                        }
                    }
                }
                else {
                    let imageView = sizeCell[i].viewWithTag(3) as! UIImageView
                    imageView.image = image[1]
                }
                
            }
        }
            // 옵션을 눌렀을 때
        else if indexPath.section == 4{
            let cell = optionCell[indexPath.row] as! OptionTableViewCell
            let optionText = cell.viewWithTag(1) as! UILabel
            let optionPriceText = cell.viewWithTag(2) as! UILabel
            
            if cell.isCheck() == false {
                cell.setIsCheck(isCheck : true)
                price += optionPrice[indexPath.row]
                optionDic[optionText.text!] = optionPriceText.text!
                
            }
            else {
                cell.setIsCheck(isCheck : false)
                price -= optionPrice[indexPath.row]
                
                if let index = optionDic.index(forKey: optionText.text!){
                    optionDic.remove(at: index)
                }
            }
        }
        
        var a = Array(String(price))
        a = a.reversed()
        
        var b :[Character] = []
        for i in 0...a.count-1 {
            b.append(a[i])
            if (i+1) % 3 == 0{
                b.append(",")
            }
        }
        b.reverse()
        
        for i in 0...b.count-1 {
            priceText += String(b[i])
        }
        priceLabel.text = String(priceText) + "원"
        
        //----------------------------------------------
        print(sizeDic)
        print(optionDic)
    }

}
