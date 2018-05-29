//
//  HomeViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/24/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var leftViewHeightConstraintCR: NSLayoutConstraint!
    @IBOutlet var leftViewHeightConstraintRR: NSLayoutConstraint!
    @IBOutlet var timerViewHeightConstraintRR: NSLayoutConstraint!
    @IBOutlet var leftViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var timerTopConstraintToScrollView: NSLayoutConstraint!
    @IBOutlet var timerHeightConstraintCR: NSLayoutConstraint!
    @IBOutlet var rightView: UIView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var timerView: UIView!
    @IBOutlet var imageHeightConstraintRR: NSLayoutConstraint!

    // Labels
    @IBOutlet var numberOfDaysLabel: UILabel!
    @IBOutlet var collegeParkLabel: UILabel!
    @IBOutlet var laurelLabel: UILabel!
    @IBOutlet var septemberLabel: UILabel!
    @IBOutlet var hashtagLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!

    let viewsCornerRadius = CGFloat(10.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Notification to always update "time to wedding" label in timerView
        NotificationCenter.default.addObserver(self,
           selector: #selector(updateDayLabel),
           name: NSNotification.Name.UIApplicationWillEnterForeground,
           object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDayLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // swiftlint:disable:next function_body_length
    fileprivate func setupViews() {
        // set image height constraint based on iphone
        if isIphone5AndBelow() {

            imageHeightConstraint.constant = 255.0
            leftViewHeightConstraintCR.constant = 144.0
            timerHeightConstraintCR.constant = 85.0
            collegeParkLabel.font = collegeParkLabel.font.withSize(30)
            laurelLabel.font = laurelLabel.font.withSize(30)

            septemberLabel.font = septemberLabel.font.withSize(30)
            hashtagLabel.font = hashtagLabel.font.withSize(30)
            dayLabel.font = dayLabel.font.withSize(30)

            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)
            setDropShadow(on: timerView, bounds: nil)
        } else if isIphone10() {
            imageHeightConstraint.constant = 380.0
            timerHeightConstraintCR.constant += 10.0
            self.view.layoutIfNeeded()
            // Because constraints have changed for this particular iphone, need to set
            // height of view to the constraint set here in order for the shadow to look good.
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerView.bounds.size.height)
            setDropShadow(on: timerView, bounds: timerViewBounds)
            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)

            self.numberOfDaysLabel.font = numberOfDaysLabel.font.withSize(35)

        } else if isIpadPro129() {
            imageHeightConstraintRR.constant += 90.0
            leftViewHeightConstraintRR.constant += 60.0
            timerViewHeightConstraintRR.constant += 30.0

            collegeParkLabel.font = collegeParkLabel.font.withSize(75)
            laurelLabel.font = laurelLabel.font.withSize(75)
            septemberLabel.font = septemberLabel.font.withSize(75)
            hashtagLabel.font = hashtagLabel.font.withSize(75)
            dayLabel.font = dayLabel.font.withSize(75)
            self.numberOfDaysLabel.font = numberOfDaysLabel.font.withSize(55)

            let leftViewBounds = CGRect(x: leftView.bounds.origin.x, y: leftView.bounds.origin.y, width: leftView.bounds.size.width, height: leftViewHeightConstraintRR.constant)
            setDropShadow(on: leftView, bounds: leftViewBounds)
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerViewHeightConstraintRR.constant)
            setDropShadow(on: timerView, bounds: timerViewBounds)
            setDropShadow(on: rightView, bounds: leftViewBounds)

        } else if isPlusPhone() {
            timerHeightConstraintCR.constant += 5.0
            imageHeightConstraint.constant += 25.0
            timerTopConstraintToScrollView.constant += 2.0

            setDropShadow(on: rightView, bounds: nil)
            let leftViewBounds = CGRect(x: leftView.bounds.origin.x, y: leftView.bounds.origin.y, width: leftView.bounds.size.width, height: leftViewHeightConstraintCR.constant)
            setDropShadow(on: leftView, bounds: leftViewBounds)
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerHeightConstraintCR.constant)
            setDropShadow(on: timerView, bounds: timerViewBounds)

            self.numberOfDaysLabel.font = numberOfDaysLabel.font.withSize(32)

        } else if isIpad105() {
            imageHeightConstraintRR.constant += 30.0
            leftViewHeightConstraintRR.constant += 10.0
            timerViewHeightConstraintRR.constant += 10.0

            let leftViewBounds = CGRect(x: leftView.bounds.origin.x, y: leftView.bounds.origin.y, width: leftView.bounds.size.width, height: leftViewHeightConstraintRR.constant)
            setDropShadow(on: leftView, bounds: leftViewBounds)
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerViewHeightConstraintRR.constant)
            setDropShadow(on: timerView, bounds: timerViewBounds)
            setDropShadow(on: rightView, bounds: leftViewBounds)
            self.numberOfDaysLabel.font = numberOfDaysLabel.font.withSize(40)

        } else {
            self.view.layoutIfNeeded()
            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)
            setDropShadow(on: timerView, bounds: nil)
        }

        // Set corner radius of uiviews
        rightView.layer.cornerRadius = viewsCornerRadius
        leftView.layer.cornerRadius = viewsCornerRadius
        timerView.layer.cornerRadius = viewsCornerRadius

    }

    /**
     Helps set drop shadow for views in home page.
     */
    fileprivate func setDropShadow(on view: UIView, bounds: CGRect?) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 1, height: 4)
        view.layer.shadowRadius = 3
        if let boundsValue = bounds {
            view.layer.shadowPath = UIBezierPath(roundedRect: boundsValue, cornerRadius: viewsCornerRadius).cgPath
        } else {
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: viewsCornerRadius).cgPath
        }

        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = 1
    }

    /**
     Function to calculate and display the time remaining to wedding label in timerView
     */
    @objc func updateDayLabel() {
        var dateText = "Wedding day is near"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let weddingDate = dateFormatter.date(from: "2018-09-22T11:00:00") else {
            numberOfDaysLabel.text = dateText
            return
        }
        // Current date
        let currentDate = Date()

        let timeDifferenceInDays = Int(weddingDate.timeIntervalSince(currentDate) / (60 * 60 * 24))

        if timeDifferenceInDays > 1 {
            dateText = "\(timeDifferenceInDays) days"
        } else if timeDifferenceInDays == 1 {
            dateText = "\(timeDifferenceInDays) day"
        } else if timeDifferenceInDays == 0 {
            let timeDifferenceInHours = Int(weddingDate.timeIntervalSince(currentDate) / (60 * 60))
            if timeDifferenceInHours > 1 {
                dateText = "\(timeDifferenceInHours) hours"
            } else if timeDifferenceInHours == 1 {
                dateText = "\(timeDifferenceInHours) hour"
            } else if timeDifferenceInHours == 0 {
                dateText = "Happens this hour"
            } else {
                dateText = "Been there, done that"
            }
        } else {
            dateText = "Been there, done that"
        }

        numberOfDaysLabel.text = dateText
    }

}
