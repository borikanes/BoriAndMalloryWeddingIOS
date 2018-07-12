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
    var foodInfoArray: [FoodInfo] = [FoodInfo(name: "Meat Pie", imageName: "meat-pie"), FoodInfo(name: "Puff-Puff", imageName: "puff_puff"), FoodInfo(name: "chin chin", imageName: "chin_chin"), FoodInfo(name: "Jollof Rice", imageName: "jollof"), FoodInfo(name: "Nigerian fried rice", imageName: "nigerian_fried_rice")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension FoodViewController: UICollectionViewDelegate {

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
        if let image = UIImage(named: currentFood.imageName) {
            cell.foodImage.image = image
        }
        return cell
    }

}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular &&
            self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
            return CGSize(width: 500.0, height: 429.0)
        }
        return CGSize(width: 320.0, height: 249.0)
    }
}
