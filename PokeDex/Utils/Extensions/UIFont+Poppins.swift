//
//  UIFont+Poppins.swift
//  PokeDex
//
//  Created by Caue Camara on 11/05/23.
//

import UIKit

extension UIFont {
    enum PoppinsWeight: String {
        case regular
        case bold
    }
    
    static func poppins(ofSize: CGFloat, weight: PoppinsWeight) -> UIFont? {
        return UIFont(name: "Poppins-\(weight.rawValue.capitalized)", size: ofSize)
    }
}
