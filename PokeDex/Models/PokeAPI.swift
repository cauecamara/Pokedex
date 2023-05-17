//
//  PokeAPI.swift
//  PokeDex
//
//  Created by Caue Camara on 07/05/23.
//

import UIKit
import Alamofire

class PokeAPI {
    let urlAPI = "https://pokeapi.co/api/v2/pokemon/?limit=50"
    var listaDePokemons: [Pokemon] = []

    func getPokemons() async throws -> [Pokemon] {
        let result = try await AF.request(urlAPI).serializingDecodable(PokeAPIModel.self).value
        var lista: [Pokemon] = []
        
        for pokemon in result.results {
            async let poke = getPokemon(url: pokemon.url)
            try await lista.append(poke)
        }
        return lista
    }

    func getPokemon(url: String) async throws -> Pokemon {
        return try await AF.request(url).serializingDecodable(Pokemon.self).value
    }
    
    func getAboutPokemon(url: String) async throws -> About {
        return try await AF.request(url).serializingDecodable(About.self).value
    }
    
}
