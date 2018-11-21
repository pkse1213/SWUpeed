//
//  Menu.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 12..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//
import UIKit
import Foundation

class Menu {
    var storeName: String?
    var menuName: String?
    var options: [String:String]?
    var size: [String:String]?
    var totalPrice: Int?
    
    init(storeName: String, menuName: String, size: [String:String], options: [String:String] , totalPrice: Int){
        self.storeName = storeName
        self.menuName = menuName
        self.size = size
        self.options = options
        self.totalPrice = totalPrice
    }
}
