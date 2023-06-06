//
//  FavoritsPokemons.swift
//  PokeDex
//
//  Created by Caue Camara on 22/05/23.
//

import UIKit

class FavoritsPokemons: UIViewController {

    let pokedexViewController = PokedexViewController()

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 104, height: 108)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 8
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokeCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.backgroundColor = .red
        collectionView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
            self.collectionView.dataSource = self
    }
}

extension FavoritsPokemons: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "pokeCell",
            for: indexPath
        ) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(
            name: "Charmander",
            id: 4, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png",
                       isFavorite: true)
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
}
