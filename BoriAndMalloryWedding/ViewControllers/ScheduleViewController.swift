//
//  ScheduleViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/3/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet var firstStackTopConstraint: NSLayoutConstraint!
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
        if isIphone10() {
            firstStackTopConstraint.constant += 60.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
