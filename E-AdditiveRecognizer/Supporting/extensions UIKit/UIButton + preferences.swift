//
//  UIButton + preferences.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 13/09/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

}
