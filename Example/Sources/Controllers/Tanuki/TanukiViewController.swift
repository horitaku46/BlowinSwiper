//
//  TanukiViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/16.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class TanukiViewController: UIViewController {

    private var menuViewController: MenuViewController!
    private var backgroundColor: UIColor = .white

    class func make(_ target: UIViewController, backgroundColor: UIColor) -> UIViewController {
        let viewController = UIStoryboard(name: "TanukiViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "TanukiViewController") as! TanukiViewController
        viewController.backgroundColor = backgroundColor
        return viewController
    }

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "tanuki.jpg")
            imageView.contentMode = .scaleAspectFit
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
    }
}
