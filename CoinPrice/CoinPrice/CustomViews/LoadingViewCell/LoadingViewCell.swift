//
//  LoadingViewCell.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import UIKit

class LoadingViewCell: UITableViewCell {

    @IBOutlet weak var loadingImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rotateView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func rotateView() {
        let rotationAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.loadingImageView.transform = self.loadingImageView.transform.rotated(by: .pi)
        }
        rotationAnimation.addCompletion { _ in
            self.rotateView()
        }
        rotationAnimation.startAnimation()
    }

}
