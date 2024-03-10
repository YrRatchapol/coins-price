//
//  InviteViewCell.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 11/3/24.
//

import UIKit

class InviteViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var inviteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configUI() {
        shadowView.layer.cornerRadius = 8
        shadowView.dropShadow()

        let labelText = "You can earn $10 when you invite a friend to buy crypto. Invite your friend"

        let attributedString = NSMutableAttributedString(string: labelText)

        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular),
                                      range: NSRange(location: 0, length: 56))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black,
                                      range: NSRange(location: 0, length: 56))

        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                      range: NSRange(location: 56, length:labelText.count - 56))
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#3296E6"),
                                      range: NSRange(location: 56, length: labelText.count - 56))

        // กำหนด NSAttributedString ให้กับ label
        inviteLabel.text = ""
        inviteLabel.attributedText = attributedString
    }

}
