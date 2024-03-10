//
//  CustomPullToRefreshView.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import UIKit

class CustomPullToRefreshView: UIRefreshControl {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var loadingImageView: UIImageView!

    var rotationAnimation: UIViewPropertyAnimator?

    override func awakeFromNib() {
       super.awakeFromNib()
        shadowView.layer.cornerRadius = self.frame.width/2
        shadowView.dropShadow()
        tintColor = .clear
    }

    func start() {
        rotationAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.loadingImageView.transform = self.loadingImageView.transform.rotated(by: .pi)
        }

        // เมื่อ animation เสร็จสิ้น ให้เริ่ม animation ใหม่อีกรอบ
        rotationAnimation?.addCompletion { _ in
            self.start() // เริ่ม animation ใหม่
        }

        // เริ่ม animation
        rotationAnimation?.startAnimation()
    }
}
