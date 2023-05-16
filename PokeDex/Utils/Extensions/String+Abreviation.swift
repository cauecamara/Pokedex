//
//  String+Abreviation.swift
//  PokeDex
//
//  Created by Caue Camara on 16/05/23.
//

import UIKit

extension String {
    var abreviation: String {
        switch self {
        case "attack":
            return "ATK"
        case "defense":
            return "DEF"
        case "hp":
            return "HP"
        case "special-attack":
            return "SATK"
        case "special-defense":
            return "SDEF"
        case "speed":
            return "SPD"
        default:
            return ""
        }
    }
}
