//
//  ColorViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/16.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class ColorViewController: UIViewController {

    private var backgroundColor: UIColor = .white

    class func make(_ target: UIViewController, backgroundColor: UIColor) -> UIViewController {
        let viewController = UIStoryboard(name: "ColorViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        viewController.backgroundColor = backgroundColor
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
    }
}
