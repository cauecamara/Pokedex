//
//  InfoViewController.swift
//  PokeDex
//
//  Created by Caue Camara on 09/05/23.
//

import UIKit

class InfoViewController: UIViewController {
    lazy var configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
    lazy var image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
    let pokeapi = PokeAPI()
    
    lazy var stackViewCima: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        
        return stackView
    }()
    
    lazy var stackViewMae: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewType, aboutPokemon, stackViewInfo, descriptionPokemon, baseStatusLabel,stackViewStatsH])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var stackViewType: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstTypePokemon, secondTypePokemon])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var stackViewInfo: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewWeight, stackViewHeight, stackViewMoves])
        stackView.axis = .horizontal
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
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
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
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var stackViewMoves: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pokeMoves, movesLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var stackViewStatsH: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewBarHP, stackViewBarATK, stackViewBarDEF, stackViewBarSpATK, stackViewBarSpDef, stackViewBarSpeed])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var stackViewBarHP: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsHp, valueStatsHp, progressbarHP])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsHp)
        return stackView
    }()
    
    lazy var stackViewBarATK: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsAtk, valueStatsAtk, progressbarATK])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsAtk)
        return stackView
    }()
    
    lazy var stackViewBarDEF: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsDef, valueStatsDef, progressbarDEF])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsDef)
        return stackView
    }()
    
    lazy var stackViewBarSpATK: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsSpAtk, valueStatsSpAtk, progressbarSPATK])
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsSpAtk)
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var stackViewBarSpDef: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsSpDef, valueStatsSpDef, progressbarSPDEF])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsSpDef)
        return stackView
    }()
    
    lazy var stackViewBarSpeed: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStatsSpeed, valueStatsSpeed, progressbarSPEED])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.setCustomSpacing(8, after: valueStatsSpeed)
        return stackView
    }()
    
    // inicio tela
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.text = "squirtle"
        return label
    }()
    
    lazy var pokemonNumber: UILabel = {
        let label = UILabel()
        label.tintColor = .white
        return label
    }()
    // segunda parte tela
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var pokeBallImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "pokeball"))
        image.contentMode = .scaleAspectFit
        image.alpha = 0.1
        return image
    }()
    
    lazy var firstTypePokemon: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Water"
        label.textAlignment = .center
        label.edgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        label.backgroundColor = .pokeTypeWater
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var secondTypePokemon: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .pokeTypeIce
        label.textAlignment = .center
        label.text = "Ice"
        label.edgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    // terceira parte telaa
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
        return image
    }()
    
    lazy var pokeWeightValue: UILabel = {
        let label = UILabel()
        label.text = "7.9kg"
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
    
    lazy var hpBar: UIBarItem = {
        let bar = UIBarItem()
        return bar
    }()
    
    
    // weight Final
    lazy var viewBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .gray
        return bar
    }()
    
    lazy var heightImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "height"))
        return image
    }()
    
    lazy var pokeHeightValue: UILabel = {
        let label = UILabel()
        label.text = "1,3m"
        label.font = .poppins(ofSize: 12, weight: .regular)
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
    // height final
    lazy var pokeMoves: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.07
        label.attributedText = NSMutableAttributedString(string: "Chlorophyll\nOvergrow", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.text = "Moves"
        label.font = .poppins(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()
   // moves final
    lazy var descriptionPokemon: UILabel = {
        let label = UILabel()
        label.text = "When it retracts its long neck into its shell, it squirts out water with vigorous force."
        label.numberOfLines = 0
        label.font = .poppins(ofSize: 10, weight: .regular)
        return label
    }()
    // quarta parte da tela
    
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
    // status hp
    lazy var labelStatsHp: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "HP"
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var valueStatsHp: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.text = "40"
        return label
    }()
    // status atk
    lazy var labelStatsAtk: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "ATK"
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var valueStatsAtk: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.text = "40"
        return label
    }()
    // Status def
    lazy var labelStatsDef: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "DEF"
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var valueStatsDef: UILabel = {
        let label = UILabel()
        label.text = "40"
        label.font = .poppins(ofSize: 10, weight: .regular)
        return label
    }()
    // Status SPATK
    lazy var labelStatsSpAtk: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "SATK"
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var valueStatsSpAtk: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.text = "40"
        return label
    }()
    // Status SPDEF
    lazy var labelStatsSpDef: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "SDEF"
        label.font = .poppins(ofSize: 10, weight: .bold)
        return label
    }()
    
    lazy var valueStatsSpDef: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.text = "40"
        return label
    }()
    // Status Speed
    lazy var labelStatsSpeed: UILabel = {
        let label = UILabel()
        label.text = "SPD"
        label.font = .poppins(ofSize: 10, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    lazy var valueStatsSpeed: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 10, weight: .regular)
        label.text = "40"
        return label
    }()
    
    lazy var progressbarHP: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
    }()
    
    lazy var progressbarATK: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
    }()
    
    lazy var progressbarDEF: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
    }()
    
    lazy var progressbarSPATK: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
    }()
    
    lazy var progressbarSPDEF: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
    }()
    
    lazy var progressbarSPEED: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.22
        bar.progressTintColor = firstTypePokemon.backgroundColor
        return bar
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
    
        stackViewInfo.anchor(left: stackViewMae.layoutMarginsGuide.leftAnchor, right: stackViewMae.layoutMarginsGuide.rightAnchor)
        stackViewMae.layer.cornerRadius = 8
        stackViewType.anchor(height: 20)
        aboutPokemon.anchor(height: 20)
        stackViewInfo.anchor(height: 48)
        view.addSubview(viewBar)
        viewBar.anchor(top: stackViewInfo.topAnchor, left: stackViewWeight.rightAnchor,bottom: stackViewInfo.bottomAnchor, paddingLeft: 12.5, width: 1)
        view.addSubview(view2Bar)
        view2Bar.anchor(top: stackViewInfo.topAnchor, left: stackViewHeight.rightAnchor, bottom: stackViewInfo.bottomAnchor, paddingLeft: 12.5, width: 1)
        view.addSubview(view3Bar)
        view3Bar.anchor(top: stackViewStatsH.topAnchor, left: labelStatsHp.rightAnchor, bottom: stackViewStatsH.bottomAnchor, paddingLeft: 12.5, width: 1)
        weightImage.anchor(width: 16, height: 16)
        heightImage.anchor(width: 16, height: 16)
        stackViewStatsH.anchor(left: stackViewMae.layoutMarginsGuide.leftAnchor, right: stackViewMae.layoutMarginsGuide.rightAnchor, height: 100)

        labelStatsHp.anchor(width: 30)
        valueStatsHp.anchor(width: 20)
        
        labelStatsAtk.anchor(width: 30)
        valueStatsAtk.anchor(width: 20)
        
        labelStatsDef.anchor(width: 30)
        valueStatsDef.anchor(width: 20)
        
        labelStatsSpAtk.anchor(width: 30)
        valueStatsSpAtk.anchor(width: 20)
        
        labelStatsSpDef.anchor(width: 30)
        valueStatsSpDef.anchor(width: 20)
        
        labelStatsSpeed.anchor(width: 30)
        valueStatsSpeed.anchor(width: 20)
        
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
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingRight: 9,
            width: 200,
            height: 200)
        pokemonNumber.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: -30,paddingLeft: 30, width: 85 , height: 16)
    }
    
    func setup(id: Int, pokeTipos: [PokemonType], weight: Int, height: Int, name: String, image: String, status: [Stat]) {
        firstTypePokemon.text = pokeTipos[0].rawValue
        navigationItem.title = name.capitalized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if pokeTipos.count <= 1 {
            secondTypePokemon.text = nil
            secondTypePokemon.isHidden = true
        } else {
            secondTypePokemon.text = pokeTipos[1].rawValue
            secondTypePokemon.backgroundColor = pokeTipos[1].color
        }
        let formater = NumberFormatter()
        formater.numberStyle = .none
        formater.minimumIntegerDigits = 3
        if let numeroFormatado = formater.string(from: id as NSNumber) {
            pokemonNumber.text = "#\(numeroFormatado)"
        }
        
        
        pokeWeightValue.text = String(Double(weight) / 10)
        pokeHeightValue.text = String(Double(height) / 10)
        print("foi")
        guard let tipoPrimario = pokeTipos.first else { return }
        view.backgroundColor = tipoPrimario.color
        firstTypePokemon.backgroundColor = tipoPrimario.color
        aboutPokemon.textColor = tipoPrimario.color
        baseStatusLabel.textColor = tipoPrimario.color
        progressbarHP.progressTintColor = tipoPrimario.color
        progressbarATK.progressTintColor = tipoPrimario.color
        progressbarDEF.progressTintColor = tipoPrimario.color
        progressbarSPATK.progressTintColor = tipoPrimario.color
        progressbarSPDEF.progressTintColor = tipoPrimario.color
        progressbarSPEED.progressTintColor = tipoPrimario.color
        valueStatsHp.text = String(status[0].baseStat)
        valueStatsAtk.text = String(status[1].baseStat)
        valueStatsDef.text = String(status[2].baseStat)
        valueStatsSpAtk.text = String(status[3].baseStat)
        valueStatsSpDef.text = String(status[4].baseStat)
        valueStatsSpeed.text = String(status[5].baseStat)
        progressbarHP.progress = Float(status[0].baseStat) / 100.0 / 2.33
        progressbarATK.progress = Float(status[1].baseStat) / 100 / 2.33
        progressbarDEF.progress = Float(status[2].baseStat) / 100 / 2.33
        progressbarSPATK.progress = Float(status[3].baseStat) / 100 / 2.33
        progressbarSPDEF.progress = Float(status[4].baseStat) / 100 / 2.33
        progressbarSPEED.progress = Float(status[5].baseStat) / 100 / 2.33
        guard let url = URL(string: image) else { return }
        pokemonImage.af.setImage(withURL: url)
        
    }
}

