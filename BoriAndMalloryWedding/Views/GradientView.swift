//
//  GradientView.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/31/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

// This class is courtesy of https://medium.com/@sakhabaevegor/create-a-color-gradient-on-the-storyboard-18ccfd8158c2

import UIKit

@IBDesignable

class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    func updateView() {
        if let layer = self.layer as? CAGradientLayer {
            layer.colors = [firstColor, secondColor].map { $0.cgColor }
        }
    }
}
