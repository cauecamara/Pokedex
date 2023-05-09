//
//  PokedexViewController.swift
//  PokeDex
//
//  Created by Caue Camara on 05/05/23.
//

import UIKit

class PokedexViewController: UIViewController {
    
    let pokeapi = PokeAPI()
    var pokemons: [Pokemon] = []
    
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
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .identityPrimary
        view.addSubview(stackViewMae)
        pokeapi.getPokemons()
        stackViewMae.translatesAutoresizingMaskIntoConstraints = false
        stackViewMae.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackViewMae.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackViewMae.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stackViewMae.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        collectionView.addSubview(loading)
        loading.anchorCenterSuperview()
        loading.startAnimating()
        pokeapi.delegate = self
        
        textFieldBusca.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
    }

    
}

extension PokedexViewController: UICollectionViewDelegate {
    
}

extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell()}
        cell.setupView()
        let pokemon = pokemons[indexPath.item]
        cell.configure(name: pokemon.name, id: pokemon.id, imageURL: pokemon.sprites.frontDefault)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension PokedexViewController: APIDelegate {
    
    func listaDePokemons(listaDePokemon: [Pokemon]) {
        pokemons = listaDePokemon
        pokemons.sort()
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}
