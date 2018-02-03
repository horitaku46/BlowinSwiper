//
//  DetailViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private var bgColor = UIColor.white

    class func make(bgColor: UIColor) -> UIViewController {
        let viewController = UIStoryboard(name: "DetailViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.bgColor = bgColor
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detail"
        view.backgroundColor = bgColor
    }
}
