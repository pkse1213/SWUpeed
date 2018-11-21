//
//  MainViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 25..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var images: [UIImage] = []
        for i in 1...4 {
            images.append(UIImage(named: "mainImage\(i).png")!)
        }
        imageView.animationImages = images
        imageView.animationDuration = 4.0
        imageView.startAnimating()
    }

}
