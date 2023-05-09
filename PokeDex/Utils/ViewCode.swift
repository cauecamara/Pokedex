//
//  ViewCode.swift
//  PokeDex
//
//  Created by Caue Camara on 06/05/23.
//

import UIKit

protocol ViewCode: UIView {
    func buildViewHierachy()
    func addContraints()
    func addAdditionalConfiguration()
}

extension ViewCode {
    func addAdditionalConfiguration() { }
}

extension ViewCode {
    @discardableResult
    func setupView() -> Self {
        buildViewHierachy()
        addContraints()
        addAdditionalConfiguration()
        return self
    }
}
