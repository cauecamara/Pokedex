//
//  InfoViewController.swift
//  PokeDex
//
//  Created by Caue Camara on 09/05/23.
//

import UIKit

class InfoViewController: UIViewController {
    let pokemon: Pokemon
    let pokeapi = PokeAPI()
    var about: About?
    var mainColor: UIColor {
        return pokemon.types.first?.type.name.color ?? .white
    }
    lazy var configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
    lazy var image = UIImage(systemName: "chevron.left", withConfiguration: configuration)

    lazy var stackViewMae: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                stackViewType,
                aboutPokemon,
                stackViewInfo,
                descriptionPokemon,
                baseStatusLabel,
                stackViewStatsH
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.backgroundColor = .white
        return stackView
    }()

    lazy var stackViewType: UIStackView = {
        let stackView = UIStackView()
        for type in pokemon.types {
            let label = TypeLabel(type: type.type.name.rawValue, colorType: type.type.name.color)
            stackView.addArrangedSubview(label)
        }
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    lazy var stackViewInfo: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewWeight, stackViewHeight, stackViewMoves])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        return stackView
    }()

    lazy var stackViewWeight: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewH1, weightLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    lazy var stackViewH1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weightImage, pokeWeightValue])
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return stackView
    }()

    lazy var stackViewHeight: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewH2, heightLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    lazy var stackViewH2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heightImage, pokeHeightValue])
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return stackView
    }()

    lazy var stackViewMoves: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pokeMoves, movesLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()

    lazy var stackViewStatsH: UIStackView = {
        let stackView = UIStackView()
        pokemon.stats.forEach {
            stackView.addArrangedSubview(
                StatusView(
                    color: mainColor,
                    statsName: $0.stat.name.abreviation,
                    statsValue: $0.baseStat
                )
            )
        }
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var pokemonName: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var pokemonNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    // segunda parte tela
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var pokeBallImage: UIStackView = {
        let image = UIImageView(image: UIImage(named: "pokeball"))
        let stackView = UIStackView(arrangedSubviews: [image])
        image.contentMode = .scaleAspectFill
        stackView.alignment = .lastBaseline
        image.alpha = 0.1
        return stackView
    }()

    lazy var firstTypePokemon: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .center
        label.edgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        label.backgroundColor = .pokeTypeWater
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()

    lazy var aboutPokemon: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.textColor = firstTypePokemon.backgroundColor
        label.textAlignment = .center
        label.font = .poppins(ofSize: 14, weight: .bold)
        return label
    }()

    lazy var weightImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "weight"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var pokeWeightValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .poppins(ofSize: 10, weight: .regular)
        return label
    }()

    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textAlignment = .center
        label.font = .poppins(ofSize: 8, weight: .regular)
        return label
    }()

    lazy var hpBar = UIBarItem()
    
    lazy var viewBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .gray
        return bar
    }()

    lazy var heightImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "height"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var pokeHeightValue: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var view2Bar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .gray
        return bar
    }()

    lazy var pokeMoves: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.07
        return label
    }()

    lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.text = "Moves"
        label.font = .poppins(ofSize: 8, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var descriptionPokemon: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var view3Bar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .gray
        return bar
    }()

    lazy var baseStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Base Stats"
        label.textColor = firstTypePokemon.backgroundColor
        label.textAlignment = .center
        label.font = .poppins(ofSize: 14, weight: .bold)
        return label
    }()

    lazy var botaoBack: UIButton = {
        let botao = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        botao.setImage(image, for: .normal)
        botao.tintColor = .white
        botao.setTitle(nil, for: .normal)
        botao.addTarget(self, action: #selector(goBack), for: .allTouchEvents)
        return botao
    }()

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.addSubview(stackViewMae)
        view.backgroundColor = firstTypePokemon.backgroundColor
        stackViewMae.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 224,
            paddingLeft: 4,
            paddingBottom: 4,
            paddingRight: 4
        )
        let barButton = UIBarButtonItem(customView: botaoBack)
        navigationItem.leftBarButtonItem = barButton
        stackViewMae.isLayoutMarginsRelativeArrangement = true
        stackViewMae.layoutMargins = UIEdgeInsets(top: 56, left: 20, bottom: 20, right: 20)
        stackViewInfo.anchor(
            left: stackViewMae.layoutMarginsGuide.leftAnchor,
            right: stackViewMae.layoutMarginsGuide.rightAnchor
        )
        descriptionPokemon.anchor(
            left: stackViewMae.layoutMarginsGuide.leftAnchor,
            right: stackViewMae.layoutMarginsGuide.rightAnchor)
        stackViewMae.layer.cornerRadius = 8
        stackViewType.anchor(height: 20)
        aboutPokemon.anchor(height: 20)
        stackViewInfo.anchor(height: 48)
        view.addSubview(viewBar)
        viewBar.anchor(
            top: stackViewInfo.topAnchor,
            left: stackViewWeight.rightAnchor,
            bottom: stackViewInfo.bottomAnchor,
            paddingLeft: 12.5, width: 1)
        view.addSubview(view2Bar)
        view2Bar.anchor(
            top: stackViewInfo.topAnchor,
            left: stackViewHeight.rightAnchor,
            bottom: stackViewInfo.bottomAnchor,
            paddingLeft: 12.5, width: 1)
        view.addSubview(view3Bar)
        weightImage.anchor(width: 16, height: 16)
        heightImage.anchor(width: 16, height: 16)
        stackViewStatsH.anchor(
            left: stackViewMae.layoutMarginsGuide.leftAnchor,
            right: stackViewMae.layoutMarginsGuide.rightAnchor,
            height: 100
        )
        heightLabel.anchor(height: 12)
        weightLabel.anchor(height: 12)
        movesLabel.anchor(height: 12)
        view.addSubview(pokeBallImage)
        view.addSubview(pokemonImage)
        pokemonImage.anchor(
            bottom: stackViewType.topAnchor,
            width: 200,
            height: 200
           )
        pokemonImage.anchorCenterXToSuperview()
        view.addSubview(pokemonNumber)
        pokeBallImage.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: stackViewMae.topAnchor,
            right: view.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8,
            paddingRight: 8
        )
        pokemonNumber.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: -30,
            paddingLeft: 30,
            width: 85,
            height: 16)
        setup()
    }

    func setup() {
        var abilityName = "/"
        firstTypePokemon.text = pokemon.types.first?.type.name.rawValue.capitalized
        navigationItem.title = pokemon.name.capitalized
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        for ability in pokemon.abilities {
            abilityName += ability.ability.name.capitalized
            abilityName += "/"
        }
        pokeMoves.attributedText = NSMutableAttributedString(string: abilityName)
        Task {
            guard let about = try? await pokeapi.getAboutPokemon(url: pokemon.species.url) else { return }
            descriptionPokemon.text = about.flavorTextEntries[81].flavorText
        }
        let formater = NumberFormatter()
        formater.numberStyle = .none
        formater.minimumIntegerDigits = 3
        if let numeroFormatado = formater.string(from: pokemon.id as NSNumber) {
            pokemonNumber.text = "#\(numeroFormatado)"
        }
        pokeWeightValue.text = "\(Double(pokemon.weight) / 10) kg"
        pokeHeightValue.text = "\(Double(pokemon.height) / 10) m"
        guard let tipoPrimario = pokemon.types.first?.type.name else { return }
        view.backgroundColor = tipoPrimario.color
        firstTypePokemon.backgroundColor = tipoPrimario.color
        aboutPokemon.textColor = tipoPrimario.color
        baseStatusLabel.textColor = tipoPrimario.color
        guard
            let imageURL = pokemon.sprites.other?.officialArtwork.frontDefault,
            let url = URL(string: imageURL)
        else { return }
        pokemonImage.af.setImage(withURL: url)
    }
}
