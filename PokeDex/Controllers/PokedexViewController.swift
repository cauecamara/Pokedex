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
        pokeapi.delegate = self
        pokeapi.getPokemons()
        mainView.loading.startAnimating()
        
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
            self.mainView.loading.stopAnimating()
            self.mainView.collectionView.reloadData()
        }
    }
}
