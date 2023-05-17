//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by Caue Camara on 06/05/23.
//

import UIKit
import AlamofireImage

class PokemonCollectionViewCell: UICollectionViewCell, ViewCode {
    
    var delegate: PokemonFavoriteDelegate?
    var id = 0
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewCima, pokeImage, labelPokeName])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    lazy var stackViewCima: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [favoritar, labelPokeNumber ])
        return stackView
    }()

    lazy var labelPokeNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .poppins(ofSize: 8, weight: .regular)
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
        label.font = .poppins(ofSize: 10, weight: .regular)
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

    lazy var favoritar: UIButton = {
        let botao = UIButton()
        let image = UIImage(systemName: "star")
        let image2 = UIImage(systemName: "star.fill")
        botao.tintColor = .gray
        botao.setImage(image, for: .normal)
        botao.setImage(image2, for: .selected)
        botao.addTarget(self, action: #selector(fav), for: .touchUpInside)
        return botao
    }()

    @objc func fav(_ sender: UIButton!) {
        delegate?.favorit(pokemonID: id)
        sender.isSelected.toggle()
    }

    func buildViewHierachy() {
        addSubview(stackView)
        addSubview(quadradoCinza)
        sendSubviewToBack(quadradoCinza)
    }

    func addContraints() {
        stackView.anchorTo(superview: self, margin: 8)
        quadradoCinza.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 44)
        favoritar.anchor(width: 12, height: 12)
    }

    func addAdditionalConfiguration() {
        backgroundColor = .white
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.cornerRadius = 8
    }

    func configure(name: String, id: Int, imageURL: String, isFavorite: Bool) {
        labelPokeName.text = name.capitalized
        let formater = NumberFormatter()
        self.id = id
        labelPokeNumber.text = "#\(id)"
        guard let url = URL(string: imageURL) else { return }
        pokeImage.af.setImage(withURL: url)
        favoritar.isSelected = isFavorite
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pokeImage.image = nil
        labelPokeName.text = ""
        labelPokeNumber.text = ""
        favoritar.isSelected = false

    }
}

protocol PokemonFavoriteDelegate {
    func favorit(pokemonID: Int)
}
