//
//  SeatingInfoViewController.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/16/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class SeatingInfoViewController: UIViewController {
    
    let data: [SeatInfo] = [SeatInfo(name: "Mallory Oludemi", table: "1"),
                            SeatInfo(name: "Bori Oludemi", table: "2"),
                            SeatInfo(name: "Daddy Oludemi", table: "3")]

    @IBOutlet var seatingInfoLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var seatingTableView: UITableView!

    let plusSizeFont = CGFloat(35)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()

    }

    private func setupView() {
        if isPlusPhone() {
            seatingInfoLabel.font = seatingInfoLabel.font.withSize(35)
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
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seatingInformationCell", for: indexPath) as! SeatingInfoTableViewCell
        cell.nameLabel.text = data[indexPath.row].name
        cell.seatingNumberLabel.text = data[indexPath.row].table
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    }
}
