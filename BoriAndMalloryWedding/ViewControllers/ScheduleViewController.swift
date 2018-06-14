//
//  ScheduleViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/3/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet var churchTimeLabel: UILabel!
    @IBOutlet var horsdoeuvresLabel: UILabel!
    @IBOutlet var nigerianCeremonyLabel: UILabel!
    @IBOutlet var receptionLabel: UILabel!

    @IBOutlet var churchTimeSV: UIStackView!
    @IBOutlet var horsDeovresSV: UIStackView!
    @IBOutlet var nigerianCeremonySV: UIStackView!
    @IBOutlet var receptionSV: UIStackView!

    @IBOutlet var churchBaseView: UIView!
    @IBOutlet var horsDoeuvresBaseView: UIView!
    @IBOutlet var nigerianCeremonyBaseView: GradientView!
    @IBOutlet var receptionBaseView: GradientView!

    @IBOutlet var churchLabel: UILabel!
    @IBOutlet var ceremonyLabel: UILabel!

    @IBOutlet var churchLabelSVConstraintCR: NSLayoutConstraint!
    @IBOutlet var churchImageTrailingConstraintCR: NSLayoutConstraint!

    @IBOutlet var firstStackTopConstraint: NSLayoutConstraint!

    let iphoneSmallFont = CGFloat(27)
    let ipad129Font = CGFloat(40)
    let ipad129HeightConstant = CGFloat(213)
    let ipad129WidthConstant = CGFloat(762)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()
    }

    private func setupView() {
        if isIphone10() {
//            firstStackTopConstraint.constant += 40.0
        } else if isIphone5AndBelow() {
            churchLabel.font = churchLabel.font.withSize(25)
            ceremonyLabel.font = ceremonyLabel.font.withSize(25)

        } else if isIpadPro129() {
            firstStackTopConstraint.constant += 130.0

            churchTimeLabel.font = churchTimeLabel.font.withSize(ipad129Font)
            horsdoeuvresLabel.font = horsdoeuvresLabel.font.withSize(ipad129Font)
            nigerianCeremonyLabel.font = nigerianCeremonyLabel.font.withSize(ipad129Font)
            receptionLabel.font = receptionLabel.font.withSize(ipad129Font)

            churchBaseView.removeConstraints(churchBaseView.constraints)
            self.churchTimeSV.addConstraints([NSLayoutConstraint(item: churchBaseView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: ipad129WidthConstant), NSLayoutConstraint(item: churchBaseView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: ipad129HeightConstant)])

            horsDoeuvresBaseView.removeConstraints(horsDoeuvresBaseView.constraints)
            horsDeovresSV.addConstraints([NSLayoutConstraint(item: horsDoeuvresBaseView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: ipad129WidthConstant), NSLayoutConstraint(item: horsDoeuvresBaseView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: ipad129HeightConstant)])

            nigerianCeremonyBaseView.removeConstraints(nigerianCeremonyBaseView.constraints)
            nigerianCeremonySV.addConstraints([NSLayoutConstraint(item: nigerianCeremonyBaseView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: ipad129WidthConstant), NSLayoutConstraint(item: nigerianCeremonyBaseView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: ipad129HeightConstant)])

            receptionBaseView.removeConstraints(receptionBaseView.constraints)
            receptionSV.addConstraints([NSLayoutConstraint(item: receptionBaseView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: ipad129WidthConstant), NSLayoutConstraint(item: receptionBaseView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: ipad129HeightConstant)])

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
