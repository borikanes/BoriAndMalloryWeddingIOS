//
//  SeatingInfoTableViewCell.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 6/16/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

class SeatingInfoTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var seatingNumberBaseView: BMView!
    @IBOutlet var seatingNumberLabel: UILabel!
    @IBOutlet var tableLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if isPlusPhone() {
            self.nameLabel.font = self.nameLabel.font.withSize(35)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
