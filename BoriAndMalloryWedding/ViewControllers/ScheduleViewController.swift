//
//  ScheduleViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/3/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    let iphoneSmallFont = CGFloat(27)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()
    }

    private func setupView() {
        if isIphone5AndBelow() {

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
