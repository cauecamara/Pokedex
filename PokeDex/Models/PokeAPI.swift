//
//  PokeAPI.swift
//  PokeDex
//
//  Created by Caue Camara on 07/05/23.
//

import UIKit
import Alamofire

class PokeAPI {
    let urlAPI = "https://pokeapi.co/api/v2/pokemon/?limit=500"
    var listaDePokemons: [Pokemon] = []
    var delegate: APIDelegate?
    
    func getPokemons() {
        AF.request(urlAPI).responseDecodable(of: PokeAPIModel.self) { response in
            switch response.result {
                
            case .success(let model):
                for pokemon in model.results {
                    self.getPokemon(url: pokemon.url)
                }
              
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getPokemon(url: String) {
        AF.request(url).responseDecodable(of: Pokemon.self) { response in
            switch response.result {
                
            case .success(let pokemon):
                self.listaDePokemons.append(pokemon)
                if self.listaDePokemons.count == 500 {
                    self.delegate?.listaDePokemons(listaDePokemon: self.listaDePokemons)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

protocol APIDelegate {
    func listaDePokemons(listaDePokemon: [Pokemon])
}

