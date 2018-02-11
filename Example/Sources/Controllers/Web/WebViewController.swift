//
//  WebViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class WebViewController: UIViewController {

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "WebViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        return viewController
    }

    private var blowinSwiper: BlowinSwiper?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
    }
}
