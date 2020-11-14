//
//  UIImageViewExtension.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func addBorder(borderWidth : CGFloat , borderColor : CGColor)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.masksToBounds = true
    }
}
