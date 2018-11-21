
//
//  OrderTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 11..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class ChooBabOrderTableViewController: UITableViewController {
    
    @IBOutlet var sizeCell: [UITableViewCell]!
    @IBOutlet var optionCell: [UITableViewCell]!
    // 가격 라벨
    @IBOutlet weak var priceLabel: UILabel!
    
    var price: Int = 1700
    var image: [UIImage] = []
    var sizePrice: [Int] = [1700, 2200, 3200]
    var optionPrice: [Int] = [500, 500, 500, 500 ,500,1000,1000]
    
    var sizeDic: [String:String] = [:]
    var optionDic: [String:String] = [:]
    var priceText = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image1 = UIImage.init(named: "check.png")
        let image2 = UIImage.init(named: "unCheck.png")
    
        image.append(image1!)
        image.append(image2!)
        
        sizeDic["레귤러"] = "1,700원"
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
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
