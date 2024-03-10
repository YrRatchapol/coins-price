//
//  TopRankViewCell.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 11/3/24.
//

import UIKit

class TopRankViewCell: UITableViewCell {

    @IBOutlet weak var firstShadowView: UIView!
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstSymbolLabel: UILabel!
    @IBOutlet weak var firstChangeIconImageView: UIImageView!
    @IBOutlet weak var firstChangeLabel: UILabel!

    @IBOutlet weak var secondShadowView: UIView!
    @IBOutlet weak var secondIconImageView: UIImageView!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var secondSymbolLabel: UILabel!
    @IBOutlet weak var secondChangeIconImageView: UIImageView!
    @IBOutlet weak var secondChangeLabel: UILabel!

    @IBOutlet weak var thirdShadowView: UIView!
    @IBOutlet weak var thirdIconImageView: UIImageView!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var thirdSymbolLabel: UILabel!
    @IBOutlet weak var thirdChangeIconImageView: UIImageView!
    @IBOutlet weak var thirdChangeLabel: UILabel!

    var onTapFirst: (() -> Void)?
    var onTapSecond: (() -> Void)?
    var onTapThird: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configUI() {
        firstShadowView.layer.cornerRadius = 8
        firstShadowView.dropShadow()
        secondShadowView.layer.cornerRadius = 8
        secondShadowView.dropShadow()
        thirdShadowView.layer.cornerRadius = 8
        thirdShadowView.dropShadow()
    }

    func bindData(firstIconImageString: String?,
                  firstName: String,
                  firstSymbol: String,
                  firstChangeImage: UIImage?,
                  firstChange: String,
                  firstChangeColor: UIColor?,
                  secondIconImageString: String?,
                  secondName: String,
                  secondSymbol: String,
                  secondChangeImage: UIImage?,
                  secondChange: String,
                  secondChangeColor: UIColor?,
                  thirdIconImageString: String?,
                  thirdName: String,
                  thirdSymbol: String,
                  thirdChangeImage: UIImage?,
                  thirdChange: String,
                  thirdChangeColor: UIColor?) {
        // Rank 1
        if let url = URL(string: firstIconImageString ?? "") {
            firstIconImageView.kf.setImage(with: url)
        }

        firstNameLabel.text = firstName
        firstSymbolLabel.text = firstSymbol
        firstChangeIconImageView.image = firstChangeImage
        firstChangeLabel.text = firstChange
        firstChangeLabel.textColor = firstChangeColor ?? UIColor(named: "blackColor")

        // Rank 2
        if let url = URL(string: secondIconImageString ?? "") {
            secondIconImageView.kf.setImage(with: url)
        }

        secondNameLabel.text = secondName
        secondSymbolLabel.text = secondSymbol
        secondChangeIconImageView.image = secondChangeImage
        secondChangeLabel.text = secondChange
        secondChangeLabel.textColor = secondChangeColor ?? UIColor(named: "blackColor")

        // Rank 3
        if let url = URL(string: thirdIconImageString ?? "") {
            thirdIconImageView.kf.setImage(with: url)
        }

        thirdNameLabel.text = thirdName
        thirdSymbolLabel.text = thirdSymbol
        thirdChangeIconImageView.image = thirdChangeImage
        thirdChangeLabel.text = thirdChange
        thirdChangeLabel.textColor = thirdChangeColor ?? UIColor(named: "blackColor")
    }

    @IBAction func onTapFirstButton() {
        onTapFirst?()
    }

    @IBAction func onTapSecondButton() {
        onTapSecond?()
    }

    @IBAction func onTapThirdButton() {
        onTapThird?()
    }
}
