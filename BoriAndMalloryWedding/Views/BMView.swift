//
//  BMView.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/31/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

// Class to allow me to set certain properties for a view

import UIKit

@IBDesignable

class BMView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
