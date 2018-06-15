//
//  ScheduleViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/3/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet var nigerianTraditionalLabel: BMLabel!
    @IBOutlet var lunchLabel: BMLabel!
    @IBOutlet var horsDoeuvresLabel: BMLabel!
    @IBOutlet var churchLabel: BMLabel!

    @IBOutlet var churchBaseView: UIView!
    @IBOutlet var horsDoeuvresBaseView: UIView!
    @IBOutlet var nigerianCeremonyBaseView: GradientView!
    @IBOutlet var receptionBaseView: GradientView!

    let iphoneSmallFont = CGFloat(30)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()
    }

    private func setupView() {
        if isIphone5AndBelow() {
            churchLabel.font = churchLabel.font.withSize(iphoneSmallFont)
            nigerianTraditionalLabel.font = nigerianTraditionalLabel.font.withSize(iphoneSmallFont)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
