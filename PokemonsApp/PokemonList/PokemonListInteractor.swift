//
//  PokemonListInteractor.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 20.02.24.
//

import Foundation

protocol PokemonListBusinessLogic {
    func fetchPokemonList()
}

class PokemonListInteractor: PokemonListBusinessLogic {
    var presenter: PokemonListPresentationLogic?

    func fetchPokemonList() {
        
    }
}
