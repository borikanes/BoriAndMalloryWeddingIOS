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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier,
                                                      for: indexPath) as! FoodCollectionViewCell
        
        return cell
    }

}
