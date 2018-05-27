//
//  HomeViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/24/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var leftViewHeightConstraintRR: NSLayoutConstraint!
    @IBOutlet var imageHeightConstraintRR: NSLayoutConstraint!
    @IBOutlet var timerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var leftViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var timerTopConstraintToScrollView: NSLayoutConstraint!
    @IBOutlet var timerHeightConstraintCR: NSLayoutConstraint!
    @IBOutlet var rightView: UIView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var timerView: UIView!
    
    let viewsCornerRadius = 7.0
    
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
            
            self.view.layoutIfNeeded()
            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)
            setDropShadow(on: timerView, bounds: nil)
        } else if isIphone10() {
            imageHeightConstraint.constant = 380.0
            timerHeightConstraintCR.constant = timerHeightConstraintCR.constant + 20.0
            
            self.view.layoutIfNeeded()
            // Because constraints have changed for this particular iphone, need to set
            // height of view to the constraint set here in order for the shadow to look good.
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerView.bounds.size.height)
            setDropShadow(on: timerView, bounds: timerViewBounds)
            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)
            
        } else if isIpadPro129() {

            imageHeightConstraintRR.constant = imageHeightConstraintRR.constant + 115.0
            leftViewHeightConstraintRR.constant = leftViewHeightConstraintRR.constant + 160.0
            timerViewHeightConstraint.constant = timerViewHeightConstraint.constant + 158.0
            
            self.view.layoutIfNeeded()
            let leftViewBounds = CGRect(x: leftView.bounds.origin.x, y: leftView.bounds.origin.y, width: leftView.bounds.size.width, height: leftView.bounds.size.height)
            setDropShadow(on: leftView, bounds: leftViewBounds)
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerView.bounds.size.height)
            setDropShadow(on: timerView, bounds: timerViewBounds)
            setDropShadow(on: rightView, bounds: nil)
            
        } else if isPlusPhone() {
            
            timerHeightConstraintCR.constant = timerHeightConstraintCR.constant + 20.0
            imageHeightConstraint.constant = imageHeightConstraint.constant + 35.0
            leftViewHeightConstraint.constant = leftViewHeightConstraint.constant + 30.0
            timerTopConstraintToScrollView.constant = timerTopConstraintToScrollView.constant + 20.0
            
            self.view.layoutIfNeeded()
            setDropShadow(on: rightView, bounds: nil)
            
            let leftViewBounds = CGRect(x: leftView.bounds.origin.x, y: leftView.bounds.origin.y, width: leftView.bounds.size.width, height: leftView.bounds.size.height)
            setDropShadow(on: leftView, bounds: leftViewBounds)
            
            let timerViewBounds = CGRect(x: timerView.bounds.origin.x, y: timerView.bounds.origin.y, width: timerView.bounds.size.width, height: timerView.bounds.size.height)
            setDropShadow(on: timerView, bounds: timerViewBounds)
        } else {
            self.view.layoutIfNeeded()
            
            setDropShadow(on: rightView, bounds: nil)
            setDropShadow(on: leftView, bounds: nil)
            setDropShadow(on: timerView, bounds: nil)
        }
        
        // Set corner radius of uiviews
        rightView.layer.cornerRadius = 7.0
        leftView.layer.cornerRadius = 7.0
        timerView.layer.cornerRadius = 7.0
        
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
            view.layer.shadowPath = UIBezierPath(roundedRect: boundsValue, cornerRadius: 7.0).cgPath
        } else {
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 7.0).cgPath
        }
        
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = 1
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
