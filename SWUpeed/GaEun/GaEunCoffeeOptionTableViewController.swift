
//
//  GaEunCoffeeOptionTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 24..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class GaEunCoffeeOptionTableViewController: UITableViewController {

    @IBOutlet var sizeCell: [UITableViewCell]!
    @IBOutlet var optionCell: [UITableViewCell]!
    // 가격 라벨
    @IBOutlet weak var priceLabel: UILabel!
    
    var price: Int = 0
    var image: [UIImage] = []
    var sizePrice: [Int] = [0, 0]
    var optionPrice: [Int] = [500, 500, 500]
    
    var iceOrHot: [String] = ["",""]
    
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

        priceText1.text = iceOrHot[0]
        priceText2.text = iceOrHot[1]

        if iceOrHot[0] != "            " {
            var a: String = iceOrHot[0]
            a.removeLast()
            a = a.replacingOccurrences(of: ",", with: "")
            sizePrice[0] = Int(a)!
        }
        if iceOrHot[1] != "            " {
            var a: String = iceOrHot[1]
            a.removeLast()
            a = a.replacingOccurrences(of: ",", with: "")
            sizePrice[1] = Int(a)!
        }
        
        if iceOrHot[0] == "            " {
            let imageView1 = sizeCell[0].viewWithTag(3) as! UIImageView
            let imageView2 = sizeCell[1].viewWithTag(3) as! UIImageView
            
            imageView1.image = image[1]
            imageView2.image = image[0]
            
            
            let iceOrHotText = sizeCell[1].viewWithTag(2) as! UILabel
            sizeDic["ice"] = iceOrHotText.text
            
            priceLabel.text = iceOrHotText.text
            price = sizePrice[1]
        }
        else {
            let iceOrHotText = sizeCell[0].viewWithTag(2) as! UILabel
            sizeDic["hot"] = iceOrHotText.text
            priceLabel.text = iceOrHotText.text
            price = sizePrice[0]
        }
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
            let a = sizeCell[indexPath.row].viewWithTag(1) as! UILabel
            let b = sizeCell[indexPath.row].viewWithTag(2) as! UILabel
            
            
            if b.text == "            " {
                let alertController = UIAlertController(title: "경고", message: a.text! + " 메뉴는 존재하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("확인")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            else {
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
