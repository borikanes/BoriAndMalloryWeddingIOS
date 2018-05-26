//
//  HomeViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/24/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var timerTopConstraintToScrollView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupViews() {
        // set image height constraint based on iphone
        if isIphone5AndBelow() {
            imageHeightConstraint.constant = 215.0
        } else if isIphone10() {
            imageHeightConstraint.constant = 215.0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
