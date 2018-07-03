//
//  SeatingInfoViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/16/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class SeatingInfoViewController: UIViewController {

    private var dataFromDisk: [SeatInfo] = []
    let activityIndicator = UIActivityIndicatorView()
    let activityIndicatorDarkBaseView = UIView()

    @IBOutlet var seatingInfoLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var seatingTableView: UITableView!

    let plusSizeFont = CGFloat(35)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startActivityIndicator()
        getTimeFromAPI { timeString in
            guard let time = timeString else {
                // Handle error here
                self.stopActivityIndicator()
                self.showAlert(title: "Network Error", message: "Something went wrong")
                return
            }

            let defaults = UserDefaults.standard
            // if file doesn't exist at all then fetch.
            if !doesJsonFileExistInFileSystem() {
                self.fetchDataAndSaveLocally()
            }
            // if time exists already, just check to make sure the time is the same
            if let timeSavedInDefaults = defaults.object(forKey: "LastModifiedTime") as? String {
                if timeSavedInDefaults != time {
                    // New data, re-fetch json
                    self.fetchDataAndSaveLocally()
                    self.stopActivityIndicator()
                } else {
                    self.prepareDataSourceForTableView()
                    self.stopActivityIndicator()
                }
                // Stop indicator here
            } else {
                // Save time in user defaults
                saveModifiedTimeToUserDefaultDB(time: time)
                // Get Json from API
                self.fetchDataAndSaveLocally()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()

    }

    private func fetchDataAndSaveLocally() {
        makeNetworkCallForSeatingData { jsonData in
            guard jsonData != nil else {
                self.stopActivityIndicator()
                self.showAlert(title: "Network Error", message: "Something went wrong")
                return
            }
            guard let jsonDataUnwrapped = jsonData else {
                self.stopActivityIndicator()
                self.showAlert(title: "Something went awry", message: "Something went wrong internally, please try again")
                return
            }

            writeToDisk(json: jsonDataUnwrapped)
            self.prepareDataSourceForTableView(json: jsonDataUnwrapped)
        }
    }

    private func prepareDataSourceForTableView(json: Data? = nil) {
        guard let jsonUnwrapped = json else {
            // fetch from disk
            let jsonStringFromDisk = getFile()
            if let jsonStringFromDiskUnwrapped = jsonStringFromDisk {
                let jsonData = jsonStringFromDiskUnwrapped.data(using: .utf8)!
                guard let seatInfoArray = getSeatInformationArray(jsonData: jsonData),
                    (getSeatInformationArray(jsonData: jsonData)?.count)! > 0 else {
                        // Error handle not able to get seat info array
                        self.stopActivityIndicator()
                        self.showAlert(title: "Something went awry", message: "Something went wrong internally, please try again")
                        return
                }
                self.dataFromDisk = seatInfoArray
                self.stopActivityIndicator()
                DispatchQueue.main.async {
                    self.seatingTableView.reloadData()
                }
            } else {
                fetchDataAndSaveLocally()
            }

            return
        }

        guard let seatInfoArray = getSeatInformationArray(jsonData: jsonUnwrapped),
            (getSeatInformationArray(jsonData: jsonUnwrapped)?.count)! > 0 else {
                // Error handle not able to get seat info array
                self.stopActivityIndicator()
                self.showAlert(title: "Something went awry", message: "Something went wrong internally, please try again")
                return
        }
        self.dataFromDisk = seatInfoArray
        self.stopActivityIndicator()
        DispatchQueue.main.async {
            self.seatingTableView.reloadData()
        }
    }

    private func setupView() {
        if isPlusPhone() {
            seatingInfoLabel.font = seatingInfoLabel.font.withSize(35)
        } else if isIphone5AndBelow() {
            seatingInfoLabel.font.withSize(21)
        }
        self.searchBar.tintColor = .white
        self.searchBar.textColor = UIColor.white
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

    func showAlert(title: String, message: String) {
        let retryButton = UIAlertAction(title: "Retry", style: .default) { (_:UIAlertAction) in
            DispatchQueue.main.async {
                self.startActivityIndicator()
                self.fetchDataAndSaveLocally()
            }
        }

        // animates transition back to the first page if there's a network error
        let okButton = UIAlertAction(title: "Dismiss", style: .default) { (_:UIAlertAction) in
            DispatchQueue.main.async {
                if let tabBarController = self.tabBarController {
                    let fromView: UIView = tabBarController.selectedViewController!.view
                    let toView: UIView = (self.tabBarController?.viewControllers![0].view)!
                    UIView.transition(from: fromView, to: toView, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
                    tabBarController.selectedIndex = 0
                }
            }
        }

        // No internet connection
        if !Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "No Internet Connection", message: "Looks like you're not connected to the internet. Try connecting to WiFi or get a better cell connection.", preferredStyle: .alert)
                alertController.addAction(retryButton)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(retryButton)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension SeatingInfoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SeatingInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromDisk.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "seatingInformationCell", for: indexPath) as? SeatingInfoTableViewCell else {
            return UITableViewCell() // what should i return here
        }

        cell.nameLabel.text = dataFromDisk[indexPath.row].name
        cell.seatingNumberLabel.text = dataFromDisk[indexPath.row].table
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    }
}

extension SeatingInfoViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}
