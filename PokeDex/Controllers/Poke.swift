//
//  Poke.swift
//  PokeDex
//
//  Created by Caue Camara on 31/05/23.
//

import UIKit
import RealmSwift

class Poke: Object {
    @Persisted var nome: String
    @Persisted var spriteURL: String
    @Persisted var id: Int
    @Persisted var hp: Int
    @Persisted var def: Int
    @Persisted var atk: Int
    @Persisted var spDef: Int
    @Persisted var spATK: Int
    @Persisted var speed: Int
    @Persisted var firstType: String
    @Persisted var secondType: String?
    @Persisted var height: Int
    @Persisted var weight: Int
    @Persisted var abilities: String
    @Persisted var aboutPokemon: String
}


