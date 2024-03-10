//
//  UIView-Extension.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 9/3/24.
//

import UIKit

extension UIView {
    func dropShadow(color:UIColor = .darkGray, opacity: Float = 0.2, radius: CGFloat = 2, offset:CGSize = CGSize(width: 0, height: 2), scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}
