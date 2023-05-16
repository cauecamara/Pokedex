//
//  TypeLabel.swift
//  PokeDex
//
//  Created by Caue Camara on 16/05/23.
//

import UIKit

class TypeLabel: PaddingLabel {
    let type: String
    let colorType: UIColor
    
    init(type: String, colorType: UIColor) {
        self.type = type
        self.colorType = colorType
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = .poppins(ofSize: 10, weight: .bold)
        edgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        textColor = .white
        text = type.capitalized
        backgroundColor = colorType
        textAlignment = .center
        layer.cornerRadius = 10
        clipsToBounds = true
        textColor = .white
    }
}


    
