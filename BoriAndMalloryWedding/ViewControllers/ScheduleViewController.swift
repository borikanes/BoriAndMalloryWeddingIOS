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
    @IBOutlet var umdChapelLabel: UILabel!

    let iphoneSmallFont = CGFloat(30)
    let ipad129FontSmall = CGFloat(40)
    let ipad129Font = CGFloat(80)

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
        } else if isIpadPro129() {
            umdChapelLabel.font = umdChapelLabel.font.withSize(ipad129FontSmall)
            lunchLabel.font = lunchLabel.font.withSize(ipad129Font)
            churchLabel.font = churchLabel.font.withSize(ipad129Font)
            horsDoeuvresLabel.font = horsDoeuvresLabel.font.withSize(ipad129Font)
            nigerianTraditionalLabel.font = nigerianTraditionalLabel.font.withSize(75)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
