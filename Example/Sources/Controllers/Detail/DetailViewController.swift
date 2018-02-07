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

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.text = "Detail"
        label.font = .boldSystemFont(ofSize: 17)
        navigationItem.titleView = label

        view.backgroundColor = bgColor

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
    }
}
