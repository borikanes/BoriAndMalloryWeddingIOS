//
//  FoodDetailViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 7/14/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    @IBOutlet var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var navBarTitle: UILabel!
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodDescriptionTextView: UITextView!

    var navBarText: String?
    var imageName: String?
    var textViewText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.text = navBarText ?? "Something is wrong"
        foodImageView.image = UIImage(named: imageName!) // create default image
        foodDescriptionTextView.text = textViewText ?? "Something went wrong, tell bori he's the worst"
    }

    override func viewWillLayoutSubviews() {
        setupView()
    }

    private func setupView() {
        if isIphone10() {

        } else if isIpadPro129() {

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonClicked(_ sender: UIButton) {
    }
}
