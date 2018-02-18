//
//  WebViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "WebViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        return viewController
    }

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.scrollView.delegate = self
        }
    }

    @IBOutlet weak var toolBar: UIToolbar! {
        didSet {
            toolBar.barTintColor = .green
        }
    }

    private var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .green

        let url = URL(string: "https://www.apple.com/jp/")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
    }

    private func calcNavigationBarOriginY(_ contentOffSetY: CGFloat) -> CGFloat {
        if contentOffSetY <= 0 {
            return 20
        } else if 44 <= contentOffSetY {
            return -24
        }
        return 20 - contentOffSetY
    }
}

extension WebViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(calcNavigationBarOriginY(scrollView.contentOffset.y))
        navigationController?.navigationBar.frame.origin.y = calcNavigationBarOriginY(scrollView.contentOffset.y)
    }
}
