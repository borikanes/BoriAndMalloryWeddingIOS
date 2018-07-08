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
    private var filteredSeatData: [SeatInfo] = []
    let activityIndicator = UIActivityIndicatorView()
    let activityIndicatorDarkBaseView = UIView()
    private let refreshControl = UIRefreshControl()

    @IBOutlet var seatingInfoLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var seatingTableView: UITableView!

    let plusSizeFont = CGFloat(35)

    override func viewDidLoad() {
        super.viewDidLoad()
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

    // MARK: Helper functions for VC
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
                self.dataFromDisk.sort(by: { $0.name < $1.name })
                self.stopActivityIndicator()
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
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
        self.dataFromDisk.sort(by: { $0.name < $1.name })
        self.stopActivityIndicator()
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.seatingTableView.reloadData()
        }
    }

    private func setupView() {
        if isPlusPhone() || isIphone10() {
            seatingInfoLabel.font = seatingInfoLabel.font.withSize(45)
        } else if isIphone5AndBelow() {
            seatingInfoLabel.font.withSize(21)
        }
        self.searchBar.tintColor = .white
        self.searchBar.textColor = UIColor.white
        self.searchBar.accessibilityLabel = "seating search bar" // For UI testing purposes

        seatingTableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red: 0.502, green: 0.0, blue: 0.125, alpha: 1.0)
        if let meriendaFont = UIFont(name: "Merienda One", size: 12.0) {
            let attributes = [NSAttributedStringKey.font : meriendaFont]
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching new seating data", attributes: attributes)
        }
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }

    @objc private func refreshTableView(_ sender: Any) {
        fetchDataAndSaveLocally()
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

// MARK: UITableViewDelegate
extension SeatingInfoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: UITableViewDataSource
extension SeatingInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarIsEmpty() ? dataFromDisk.count : filteredSeatData.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? SeatingInfoTableViewCell {
            if isPlusPhone() || isIphone10() {
                customCell.nameLabel.font = customCell.nameLabel.font.withSize(23)
            } else if isIphone5AndBelow() {
                customCell.nameLabel.font = customCell.nameLabel.font.withSize(18)
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "seatingInformationCell", for: indexPath) as? SeatingInfoTableViewCell else {
            return UITableViewCell() // what should i return here
        }

        if searchBarIsEmpty() {
            cell.nameLabel.text = dataFromDisk[indexPath.row].name
            cell.seatingNumberLabel.text = dataFromDisk[indexPath.row].table
        } else {
            cell.nameLabel.text = filteredSeatData[indexPath.row].name
            cell.seatingNumberLabel.text = filteredSeatData[indexPath.row].table
        }

        return cell

    }
}

// MARK: UISearchBarDelegate
extension SeatingInfoViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.seatingTableView.reloadData() // when cancel button is clicked, it should refresh tableview
        searchBar.showsCancelButton = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchBar.text!.isEmpty {
            filterContentForSearchText(searchBar.text!)
        } else {
            // This is really for the x button. when it's clicked, it should refresh the tableview
            seatingTableView.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

    // MARK: Helper functions for Search Bar
    // https://www.raywenderlich.com/157864/uisearchcontroller-tutorial-getting-started
    func filterContentForSearchText(_ searchText: String) {
        filteredSeatData = dataFromDisk.filter({( seatInfo : SeatInfo) -> Bool in
            return seatInfo.name.lowercased().contains(searchText.lowercased())
        })

        seatingTableView.reloadData()
    }

    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
}
