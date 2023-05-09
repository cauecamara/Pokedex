//
//  PokedexView.swift
//  PokeDex
//
//  Created by Caue Camara on 09/05/23.
//

import UIKit

class PokedexView: UIView {
    
    lazy var loading = UIActivityIndicatorView(style: .large)
    
    lazy var textFieldBusca: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        return textField
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Pokédex"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .black)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 104, height: 108)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 8
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokeCell")
        return collectionView
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "pokeball"))
        return image
    }()
    
    lazy var stackViewGrupo: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, textFieldBusca])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image,label])
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var stackViewMae: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewGrupo ,collectionView])
        stackView.axis = .vertical
    
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 4, bottom: 16, right: 4)
        stackView.spacing = 24
        return stackView
    }()
    
}

extension PokedexView: ViewCode {
    
    func buildViewHierachy() {
        addSubview(stackViewMae)
        collectionView.addSubview(loading)
    }
    
    func addContraints() {
        stackViewMae.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor
        )
        image.anchor(width: 24, height: 24)
        loading.anchorCenterSuperview()
        textFieldBusca.anchor(height: 32)
    }
    
    func addAdditionalConfiguration() {
        backgroundColor = .identityPrimary
    }
    
}
