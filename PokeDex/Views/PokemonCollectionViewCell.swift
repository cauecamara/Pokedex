//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by Caue Camara on 06/05/23.
//

import UIKit
import AlamofireImage

class PokemonCollectionViewCell: UICollectionViewCell, ViewCode {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelPokeNumber ,pokeImage, labelPokeName])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    lazy var labelPokeNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 12).isActive = true
        return label
    }()
    
    lazy var pokeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var labelPokeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return label
    }()
    
    lazy var quadradoCinza: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .grayScaleBackground
        return view
    }()
    
    func buildViewHierachy() {
        addSubview(stackView)
        addSubview(quadradoCinza)
        sendSubviewToBack(quadradoCinza)
    }
    
    func addContraints() {
        stackView.anchorTo(superview: self, margin: 8)
        quadradoCinza.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 44)
    }
    
    func addAdditionalConfiguration() {
        backgroundColor = .white
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.cornerRadius = 8
    }
    
    func configure(name: String, id: Int, imageURL: String) {
        labelPokeName.text = name.capitalized
        labelPokeNumber.text = "#\(id)"
        guard let url = URL(string: imageURL) else { return }
        pokeImage.af.setImage(withURL: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokeImage.image = nil
        labelPokeName.text = ""
        labelPokeNumber.text = ""

    }
}
