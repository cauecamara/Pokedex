//
//  InfoView.swift
//  PokeDex
//
//  Created by Caue Camara on 13/05/23.
//

import UIKit

class StatusView: UIStackView {
    let color: UIColor
    let statsName: String
    let statsValue: Int

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        return label
    }()

    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        return bar
    }()

    init(
        color: UIColor,
        statsName: String,
        statsValue: Int
    ) {
        self.color = color
        self.statsName = statsName
        self.statsValue = statsValue
        super.init(frame: .zero)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StatusView: ViewCode {
    func buildViewHierachy() {
        addArrangedSubview(label)
        addArrangedSubview(valueLabel)
        addArrangedSubview(progressBar)
    }

    func addContraints() {
        label.anchor(width: 30)
        valueLabel.anchor(width: 20)
    }

    func addAdditionalConfiguration() {
        axis = .horizontal
        alignment = .center
        spacing = 25
        setCustomSpacing(8, after: valueLabel)
        progressBar.progressTintColor = color
        label.text = statsName
        valueLabel.text = statsValue.description
        progressBar.progress = Float(statsValue) / 100 / 2.33
    }

}
