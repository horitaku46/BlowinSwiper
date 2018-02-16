//
//  TanukiViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/16.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class TanukiViewController: UIViewController {

    class func make(backgroundColor: UIColor) -> UIViewController {
        let viewController = UIStoryboard(name: "TanukiViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "TanukiViewController") as! TanukiViewController
        viewController.view.backgroundColor = backgroundColor
        return viewController
    }

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "tanuki.jpg")
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .white
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    @IBAction func tapShowButton(_ sender: Any) {
    }
}
