//
//  FoodCollectionViewCell.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 7/8/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var angleIndicatorImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: foodImage.frame.width, height: foodImage.frame.height)
//        gradientLayer.colors = [UIColor.clear.withAlphaComponent(0.0).cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.0, 0.9]
//        foodImage.layer.addSublayer(gradientLayer)
    }
}
