//
//  PokedexViewController.swift
//  PokeDex
//
//  Created by Caue Camara on 05/05/23.
//
import UIKit
import PokemonAPI
import CoreData
import RealmSwift

class PokedexViewController: UIViewController {
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print(error)
            return nil
        }
    }
    var resultado: Results<Poke>? { guard let realm = realm else { return nil }
        let lista = realm.objects(Poke.self)
        if searchText.isEmpty {
            return lista
        } else {
            return lista.filter("nome CONTAINS[cd] %@", searchText)
        }
    }
    var resultadoFavorite: Results<Poke>? {
        let filtroID = resultado?.filter("id IN %@", favoriteIDs)
        if searchText.isEmpty {
            return filtroID
        } else {
            return filtroID?.filter("nome CONTAINS[cd] %@", searchText)
        }
    }
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
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error)
        }
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.tabBar.delegate = self
        mainView.loading.startAnimating()
        mainView.tabBar.isUserInteractionEnabled = false
        mainView.textFieldBusca.delegate = self
        navigationController?.isNavigationBarHidden = true
        if resultado?.count == 50 {
            print("foi")
        } else {
            Task {
                guard let pokemons = try? await pokeapi.getPokemons() else { return }
                self.pokemons = pokemons
                mainView.collectionView.reloadData()
                mainView.loading.stopAnimating()
                mainView.tabBar.isUserInteractionEnabled = true
                if resultado?.count ?? 0 <= 49 {
                    saveItens(pokemons: self.pokemons)
                }
            }
            
        }
        mainView.collectionView.reloadData()
        mainView.loading.stopAnimating()
        mainView.tabBar.isUserInteractionEnabled = true
    }
    func saveItens(pokemons: [Pokemon]) {
        guard let realm = realm else { return }
        for pokemon in pokemons {
            do {
                try realm.write {
                    var poke = Poke()
                    pokemon.abilities.count
                    switch pokemon.abilities.count {
                    case 1:
                        let ability = pokemon.abilities[0].ability.name
                        poke.abilities = ability
                    case 2:
                        let ability = pokemon.abilities[0].ability.name + pokemon.abilities[1].ability.name
                        poke.abilities = ability
                    case 3:
                        let ability = pokemon.abilities[0].ability.name + pokemon.abilities[1].ability.name + pokemon.abilities[2].ability.name
                        poke.abilities = ability
                    default:
                        let ability = pokemon.abilities[0].ability.name
                        poke.abilities = ability
                    }
                    poke.nome = pokemon.name
                    poke.id = pokemon.id
                    poke.spriteURL = pokemon.sprites.other?.officialArtwork.frontDefault ?? "sprite not found"
                    poke.hp = pokemon.stats[0].baseStat
                    poke.atk = pokemon.stats[1].baseStat
                    poke.def = pokemon.stats[2].baseStat
                    poke.spATK = pokemon.stats[3].baseStat
                    poke.spDef = pokemon.stats[4].baseStat
                    poke.speed = pokemon.stats[5].baseStat
                    if pokemon.types.count == 2 {
                        poke.firstType = pokemon.types[0].type.name.rawValue
                        poke.secondType = pokemon.types.last?.type.name.rawValue
                    } else {
                        poke.firstType = pokemon.types[0].type.name.rawValue
                    }
                    poke.height = pokemon.height
                    poke.weight = pokemon.weight
                    print(poke)
                    realm.add(poke)
                }
            } catch {
                print("sr error \(error)")
            }
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
//        if isFavoriteSelected {
//            pokemon = pokemonsFavoritos[indexPath.item]
//        } else {
//            pokemon = pokemonsFiltrados[indexPath.item]
//        }
//
        guard let resultado = resultado?[indexPath.item] else { return UICollectionViewCell() }
        if isFavoriteSelected {
            guard let resultadoFavorite = resultadoFavorite?[indexPath.item] else { return UICollectionViewCell() }
            let isFavorite = favoriteIDs.contains(resultadoFavorite.id)
            cell.configure(
                name: resultadoFavorite.nome,
                id: resultadoFavorite.id,
                imageURL: resultadoFavorite.spriteURL,
                isFavorite: isFavorite
                )
                } else {
                    let isFavorite = favoriteIDs.contains(resultado.id)
                    cell.configure(
                        name: resultado.nome,
                        id: resultado.id,
                        imageURL: resultado.spriteURL,
                        isFavorite: isFavorite
                    )
                }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resultado = resultado else { return resultado?.count ?? 0}
        guard let resultadoFavorite = resultadoFavorite else { return resultadoFavorite?.count ?? 0}
        return !isFavoriteSelected ? resultado.count : resultadoFavorite.count
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
