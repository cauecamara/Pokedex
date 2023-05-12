//
//  PaddingLabel.swift
//  PokeDex
//
//  Created by Caue Camara on 10/05/23.
//

import UIKit

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    var edgeInsets: UIEdgeInsets? {
        didSet {
            guard let edgeInsets else { return }
            topInset = edgeInsets.top
            bottomInset = edgeInsets.bottom
            leftInset = edgeInsets.left
            rightInset = edgeInsets.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
