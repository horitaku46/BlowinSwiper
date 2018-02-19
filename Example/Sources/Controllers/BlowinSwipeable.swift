//
//  BlowinSwipeable.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/19.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

protocol BlowinSwipeable: class {
    var blowinSwiper: BlowinSwiper? { get set }
    func setSwipeBack()
}

extension BlowinSwipeable where Self: UIViewController {

    func setSwipeBack() {
        guard let navigationController = self.navigationController else { return }
        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController.delegate = blowinSwiper
    }
}
