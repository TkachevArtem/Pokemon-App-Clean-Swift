//
//  PokemonDetailModel.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation

struct PokemonDetail: Codable {
    let weight: Int
    let height: Int
    let types: [TypeDetails]
    let sprites: SpriteDetails
}

struct TypeDetails: Codable {
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct SpriteDetails: Codable {
    let front_default: String
}
