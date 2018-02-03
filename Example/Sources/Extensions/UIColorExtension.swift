//
//  UIColorExtension.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

struct ColorHex {
    static let green       = 0x13ad49
    static let purple      = 0x964da8
    static let lightBlue   = 0x96cee6
    static let lightYellow = 0xf0d782
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0x00FF00) >> 8 ) / 255
        let blue = CGFloat((hex & 0x0000FF) >> 0 ) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
