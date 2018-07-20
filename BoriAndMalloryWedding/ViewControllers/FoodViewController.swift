//
//  FoodViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 7/8/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var selectedIndex: Int?

    let collectionCellReuseIdentifier = "foodCollectionViewCell"
    var foodInfoArray: [FoodInfo] = [FoodInfo(name: "Meat Pie", imageName: "meat_pie", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Puff Puff", imageName: "puff_puff", textColor: UIColor.black, indicatorImageName: "angle_indicator"), FoodInfo(name: "Scotch egg", imageName: "scotch_egg", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "chin chin", imageName: "chin_chin", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Jollof Rice", imageName: "jollof", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "Nigerian fried rice", imageName: "nigerian_fried_rice", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Pounded yam & egusi", imageName: "efo_elegusi", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "Baked Salmon", imageName: "salmon", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "Italian seasoned chicken", imageName: "italian_chicken", textColor: UIColor.black, indicatorImageName: "angle_indicator")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodToDetailSegue" {
            if let foodDetailViewController = segue.destination as? FoodDetailViewController, let index = selectedIndex {
                    let currentFood = foodInfoArray[index]
                    foodDetailViewController.navBarText = currentFood.name
                if currentFood.imageName == "nigerian_fried_rice" || currentFood.imageName == "scotch_egg" || currentFood.imageName == "efo_elegusi" {
                    if UIImage(named: "\(currentFood.imageName)_clean") != nil {
                        foodDetailViewController.imageName = "\(currentFood.imageName)_clean"
                    } // ELSE should show default image
                } else {
                    if UIImage(named: currentFood.imageName) != nil {
                        foodDetailViewController.imageName = currentFood.imageName
                    } // ELSE should show default image
                }
            }
        }
     }

    @objc func cellClicked(sender: UITapGestureRecognizer) {
    }

    @IBAction func unwindFromDetailToFoodVC(segue: UIStoryboardSegue) {
    }
}

extension FoodViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "foodToDetailSegue", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedIndex = indexPath.row
        return true
    }
}

extension FoodViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodInfoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier,
                                                            for: indexPath) as? FoodCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5.0
        let currentFood = foodInfoArray[indexPath.row]
        cell.foodName.text = currentFood.name
        cell.foodName.textColor = currentFood.textColor
        if isIpadPro129() {
            cell.foodName.font = cell.foodName.font.withSize(35)
        }
        if let image = UIImage(named: currentFood.imageName), let indicatorImage = UIImage(named: currentFood.indicatorImageName) {
            cell.foodImage.image = image
            cell.angleIndicatorImageView.image = indicatorImage
        }

        return cell
    }

    private func setDropShadow(on view: UIView, bounds: CGRect? = nil) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 1, height: 8)
        view.layer.shadowRadius = 3
        if let boundsValue = bounds {
            view.layer.shadowPath = UIBezierPath(roundedRect: boundsValue, cornerRadius: CGFloat(0)).cgPath
        } else {
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: CGFloat(0)).cgPath
        }

        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = 1
    }
}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if isPlusPhone() {
            return CGSize(width: 362.0, height: 271.0)
        }
        if self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular &&
            self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
            return CGSize(width: 480.0, height: 373.5)
//            return CGSize(width: 350.0, height: 269)
        }
        return CGSize(width: 320.0, height: 239.0)
    }
}
