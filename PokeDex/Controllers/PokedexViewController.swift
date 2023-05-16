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
    var types: [TypeElement] = []

    lazy var mainView: PokedexView = {
        let view = PokedexView()
        view.setupView()
        return view
    }()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.loading.startAnimating()
        navigationController?.isNavigationBarHidden = true

        Task {
            guard let pokemons = try? await pokeapi.getPokemons() else { return }
            self.pokemons = pokemons
            mainView.collectionView.reloadData()
            mainView.loading.stopAnimating()
        }
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        let infoViewController = InfoViewController(pokemon: pokemon)
//        let pokemonType = pokemon.types.compactMap { return $0.type.name }
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(infoViewController, animated: true)
    }
}

extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "pokeCell",
            for: indexPath
        ) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
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
