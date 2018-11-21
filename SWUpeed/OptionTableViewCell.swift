//
//  OptionTableViewCell.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 11..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//
import UIKit
import Foundation

class OptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkImage : UIImageView!
    
    var isStatus:Bool = false
    func isCheck() -> Bool {
        return isStatus
    }
    
    func setIsCheck(isCheck : Bool){
        self.isStatus = isCheck
        
        if isCheck == true{
            self.checkImage.image = UIImage.init(named: "check.png")
        }        else if isCheck == false{
            self.checkImage.image = UIImage.init(named: "unCheck.png")
        }
    }
}
