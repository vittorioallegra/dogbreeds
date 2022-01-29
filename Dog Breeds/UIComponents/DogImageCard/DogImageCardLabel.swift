//
//  DogImageCardLabel.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class DogImageCardLabel: UILabel {
    let padding: CGFloat = 16
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(
            top: 0,
            left: self.padding,
            bottom: 0,
            right: self.padding
        )
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + self.padding * 2,
            height: size.height
        )
    }
}
