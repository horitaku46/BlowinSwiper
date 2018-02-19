//
//  UILabelExtension.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/19.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

extension UILabel {

    static func navigationItemTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }
}
