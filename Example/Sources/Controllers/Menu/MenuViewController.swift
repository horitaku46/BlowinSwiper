//
//  MenuViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import SwipeMenuViewController

final class MenuViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .black
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "MenuViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return viewController
    }

    private var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuLabel = UILabel()
        menuLabel.text = "Menu"
        menuLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = menuLabel
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
    }

    @IBAction func tapShowButton(_ sender: Any) {
        let viewController = WebViewController.make()
        navigationController?.show(viewController, sender: nil)
    }
}
