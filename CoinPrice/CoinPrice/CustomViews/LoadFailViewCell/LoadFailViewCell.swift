//
//  LoadFailViewCell.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import UIKit

class LoadFailViewCell: UITableViewCell {

    var tryAgain: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapTryAgainButton() {
        tryAgain?()
    }
}
