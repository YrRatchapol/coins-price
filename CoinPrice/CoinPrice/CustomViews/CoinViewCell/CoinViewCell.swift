//
//  CoinViewCell.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 9/3/24.
//

import UIKit
import Kingfisher

class CoinViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeIconImageView: UIImageView!
    @IBOutlet weak var changeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configUI() {
        shadowView.layer.cornerRadius = 8
        shadowView.dropShadow()
    }

    func bindData(iconImageString: String?,
                  name: String,
                  symbol: String,
                  price: String,
                  changeImage: UIImage?,
                  change: String,
                  changeColor: UIColor?) {
        if let url = URL(string: iconImageString ?? "") {
            iconImageView.kf.setImage(with: url)
        }

        nameLabel.text = name
        symbolLabel.text = symbol
        priceLabel.text = price
        changeIconImageView.image = changeImage
        changeLabel.text = change
        changeLabel.textColor = changeColor ?? UIColor(named: "blackColor")
    }
}
