//
//  FoodViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 7/8/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    let collectionCellReuseIdentifier = "foodCollectionViewCell"
    var foodInfoArray: [FoodInfo] = [FoodInfo(name: "Meat Pie", imageName: "meat-pie", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Puff-Puff", imageName: "puff_puff", textColor: UIColor.black, indicatorImageName: "angle_indicator"), FoodInfo(name: "Scotch egg", imageName: "scotch_egg", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "chin chin", imageName: "chin_chin", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Jollof Rice", imageName: "jollof", textColor: UIColor.white, indicatorImageName: "angle_indicator"), FoodInfo(name: "Nigerian fried rice", imageName: "nigerian_fried_rice", textColor: UIColor.white, indicatorImageName: "angle_indicator_white"), FoodInfo(name: "Pounded yam & egusi", imageName: "efo_elegusi", textColor: UIColor.white, indicatorImageName: "angle_indicator")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.

     }

    @objc func cellClicked(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "foodToDetailSegue", sender: nil)
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

    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
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
        let currentFood = foodInfoArray[indexPath.row]
        cell.foodName.text = currentFood.name
        cell.foodName.textColor = currentFood.textColor
        if isIpadPro129() {
            cell.foodName.font = cell.foodName.font.withSize(35)
        }
        if let image = UIImage(named: currentFood.imageName), let indicatorImage = UIImage(named: currentFood.indicatorImageName) {
            cell.foodImage.image = image
            cell.detailButton.imageView?.image = indicatorImage
        }
        // Add tap gesture to cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FoodViewController.cellClicked))
        cell.addGestureRecognizer(tapGesture)
        return cell
    }

}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular &&
            self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
            return CGSize(width: 480.0, height: 373.5)
        }
        return CGSize(width: 320.0, height: 249.0)
    }
}
