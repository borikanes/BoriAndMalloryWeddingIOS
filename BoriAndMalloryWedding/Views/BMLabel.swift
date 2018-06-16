//
//  BMLabel.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/14/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

@IBDesignable

class BMLabel: UILabel {
    @IBInspectable var kerning : CGFloat = 0 {
        didSet {
            if let labelText = self.text {
                // https://stackoverflow.com/questions/27535901/ios-8-change-character-spacing-on-uilabel-within-interface-builder
                let attributedString = NSMutableAttributedString(string: labelText)
                attributedString.addAttribute(NSAttributedStringKey.kern, value: kerning, range: NSRange(location: 0, length: attributedString.length - 1))
                attributedText = attributedString
            }
        }
    }

    func kern(value: CGFloat) {
        if let labelText = self.text {
            // https://stackoverflow.com/questions/27535901/ios-8-change-character-spacing-on-uilabel-within-interface-builder
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
