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

    private let activityIndicator = UIActivityIndicatorView()
    private let activityIndicatorDarkBaseView = UIView()
    private let filename = "food-description.json"
    private let defaultTextviewText = "Something went wrong but we promise the meals are great."
    var navBarText: String?
    var imageName: String?
    var textViewText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.text = navBarText ?? "Something is wrong"
        foodImageView.image = UIImage(named: imageName!) // create default image
//        foodDescriptionTextView.text = textViewText ?? defaultTextviewText
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLastModifiedTime()
        foodDescriptionTextView.text = ""
    }

    override func viewWillLayoutSubviews() {
        setupView()
    }

    private func setupView() {
        if isIphone10() {
            stackViewTopConstraint.constant -= 21.0
        } else if isIpadPro129() {

        } else if isPlusPhone() {

        } else if isIpad105() {

        } else if isIphone5AndBelow() {
            stackViewTopConstraint.constant -= 1.0
//            foodDescriptionTextView.font = foodDescriptionTextView.font?.withSize(14)
        }
    }

    private func startActivityIndicator() {
        activityIndicatorDarkBaseView.frame = CGRect(x: self.view.frame.origin.x , y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        activityIndicatorDarkBaseView.backgroundColor = UIColor.darkGray
        activityIndicatorDarkBaseView.alpha = 0.7

        self.activityIndicator.frame.origin = CGPoint(x: activityIndicatorDarkBaseView.frame.size.width / 2, y: activityIndicatorDarkBaseView.frame.size.height / 2)
        activityIndicatorDarkBaseView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()

        self.view.addSubview(activityIndicatorDarkBaseView)
    }

    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicatorDarkBaseView.removeFromSuperview()
        }
    }

    private func showTextViewDefaultMessage() {
        foodDescriptionTextView.text = defaultTextviewText
    }

    private func getFoodDescriptionObject(jsonData: Data) -> FoodDescriptionInfo? {
        let decoder = JSONDecoder()
        var foodDescriptionInfo: FoodDescriptionInfo?
        do {
            foodDescriptionInfo = try decoder.decode(FoodDescriptionInfo.self, from: jsonData)
        } catch {
            return nil
        }
        return foodDescriptionInfo
    }

    private func checkLastModifiedTime() {
        self.startActivityIndicator()
        makeNetworkCall(for: "https://styf7r70gj.execute-api.us-east-1.amazonaws.com/prod/time?for=food") { timeData in
            guard let time = timeData else {
                // Handle error here
                DispatchQueue.main.async {
                    self.showTextViewDefaultMessage()
                }
                self.stopActivityIndicator()
                return
            }
            guard let timeString = String(data: time, encoding: .utf8) else {
                DispatchQueue.main.async {
                    self.showTextViewDefaultMessage()
                }
                self.stopActivityIndicator()
                return
            }
            let defaults = UserDefaults.standard
            if let timeSavedInDefaults = defaults.object(forKey: "FoodLastModifiedTime") as? String {
                if timeSavedInDefaults != timeString {
                    // New data, re-fetch json
                    self.fetchDataAndSaveJsonFileLocally()
                    self.stopActivityIndicator()
                } else {
                    DispatchQueue.main.async {
                        self.fetchFileFromLocalAndSetTextView()
                    }
                    self.stopActivityIndicator()
                }
            } else {
                // Save time in user defaults
                saveModifiedTimeToUserDefaultDB(time: timeString, keyName: "FoodLastModifiedTime")
                // Get Json from API
                self.fetchDataAndSaveJsonFileLocally()
            }
        }
    }

    private func fetchDataAndSaveJsonFileLocally() {
        makeNetworkCall(for: "https://styf7r70gj.execute-api.us-east-1.amazonaws.com/prod/food-description") { foodDescriptionData in
            guard let foodDescriptionDataUnwrapped = foodDescriptionData else {
                self.stopActivityIndicator()
                return
            }
            writeToDisk(json: foodDescriptionDataUnwrapped, filename: self.filename)
            DispatchQueue.main.async {
                self.setTextViewText(with: foodDescriptionDataUnwrapped)
            }
            self.stopActivityIndicator()
        }
    }

    private func fetchFileFromLocalAndSetTextView() {
        if !doesJsonFileExistInFileSystem(filename: filename) {
            fetchDataAndSaveJsonFileLocally()
        } else {
            if let foodDescriptionJson = getFoodDescriptionJsonFile(from: self.filename) {
                setTextViewText(with: foodDescriptionJson)
            } else {
                self.showTextViewDefaultMessage()
            }
            stopActivityIndicator()
        }
    }

    private func getFoodDescriptionJsonFile(from filename: String) -> Data? {
        var jsonData: Data?
        do {
            jsonData = try Data(contentsOf: getDocumentsDirectory().appendingPathComponent(filename))
        } catch {
            // handle error
            return nil
        }
        return jsonData
    }

    private func setTextViewText(with data: Data) {
        if let foodDescriptionJson = getFoodDescriptionObject(jsonData: data) {
            guard let imageNameUnwrapped = self.imageName else {
                foodDescriptionTextView.text = foodDescriptionJson.default_image
                return
            }
            switch imageNameUnwrapped {
            case "chin_chin":
                foodDescriptionTextView.text = foodDescriptionJson.chin_chin
            case "efo_elegusi_clean":
                foodDescriptionTextView.text = foodDescriptionJson.efo_elegusi_clean
            case "italian_chicken":
                foodDescriptionTextView.text = foodDescriptionJson.italian_chicken
            case "jollof":
                foodDescriptionTextView.text = foodDescriptionJson.jollof
            case "meat_pie":
                foodDescriptionTextView.text = foodDescriptionJson.meat_pie
            case "nigerian_fried_rice_clean":
                foodDescriptionTextView.text = foodDescriptionJson.nigerian_fried_rice_clean
            case "puff_puff":
                foodDescriptionTextView.text = foodDescriptionJson.puff_puff
            case "salmon":
                foodDescriptionTextView.text = foodDescriptionJson.salmon
            case "scotch_egg_clean":
                foodDescriptionTextView.text = foodDescriptionJson.scotch_egg_clean
            default:
                foodDescriptionTextView.text = foodDescriptionJson.default_image
            }
        } else {
            self.showTextViewDefaultMessage()
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
