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
    var favoriteIDs: [Int] {
        guard let fav = UserDefaults.standard.object(forKey: "PokemonsFavoritos") as? [Int] else { return [] }
        return fav
    }
    
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
        cell.delegate = self
        let pokemon = pokemons[indexPath.item]
        let isFavorite = favoriteIDs.contains(pokemon.id)
        cell.configure(
            name: pokemon.name,
            id: pokemon.id,
            imageURL: pokemon.sprites.other?.officialArtwork.frontDefault ?? "",
            isFavorite: isFavorite
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension PokedexViewController: PokemonFavoriteDelegate {
    func favorit(pokemonID: Int) {
        var lista = favoriteIDs
        if lista.contains(pokemonID) {
            lista.removeAll { $0 == pokemonID }
        } else {
            lista.append(pokemonID)
        }
        
        UserDefaults.standard.set(lista, forKey: "PokemonsFavoritos")
    }
}
