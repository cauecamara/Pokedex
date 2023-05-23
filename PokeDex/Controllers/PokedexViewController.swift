//
//  PokedexViewController.swift
//  PokeDex
//
//  Created by Caue Camara on 05/05/23.
//

import UIKit
import PokemonAPI

class PokedexViewController: UIViewController {
    
    let pokeapi = PokeAPI()
    let pokeapiLib = PokemonAPI()
    var pokemons: [Pokemon] = []
    var pokemonsFiltrados: [Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        
        return pokemons.filter { pokemon in
            pokemon.name.contains(searchText)
        }
    }
    var pokemonsFavoritos: [Pokemon] {
        if !searchText.isEmpty {
            return pokemons.filter { favoriteIDs.contains($0.id) }.filter { $0.name.contains(searchText) }
        } else {
            return pokemonsFiltrados.filter { favoriteIDs.contains($0.id) }
        }
    }
    var types: [TypeElement] = []
    var pokeName: [String] = []
    var isFavoriteSelected: Bool = false
    var isSearch: Bool = false
    var valor = 0
    var searchText = ""
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
        mainView.tabBar.delegate = self
        mainView.loading.startAnimating()
        mainView.tabBar.isUserInteractionEnabled = false
        mainView.textFieldBusca.delegate = self
        navigationController?.isNavigationBarHidden = true

        Task {
            guard let pokemons = try? await pokeapi.getPokemons() else { return }
            self.pokemons = pokemons
            mainView.collectionView.reloadData()
            mainView.loading.stopAnimating()
            mainView.tabBar.isUserInteractionEnabled = true
        }
    }

    func searchPokemon(pokeList: [Pokemon]) -> Pokemon? {

        for pokemon in pokeList {
            guard let texto = self.mainView.textFieldBusca.text else { return nil }
            if pokemon.name.contains(texto) {
                return pokemon
            }
        }
        return nil
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon
        if isFavoriteSelected {
            pokemon = pokemonsFavoritos[indexPath.item]
        } else {
            pokemon = pokemonsFiltrados[indexPath.item]
        }
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
        var pokemon: Pokemon

        if isFavoriteSelected {
            pokemon = pokemonsFavoritos[indexPath.item]
        } else {
            pokemon = pokemonsFiltrados[indexPath.item]
        }

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
        return isFavoriteSelected ? pokemonsFavoritos.count : pokemonsFiltrados.count
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

extension PokedexViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        isFavoriteSelected = item.title == "Favorites"
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
        }
    }
}

extension PokedexViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.lowercased()
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
