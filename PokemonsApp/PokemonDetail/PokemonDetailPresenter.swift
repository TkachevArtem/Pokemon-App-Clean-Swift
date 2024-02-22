//
//  PokemonDetailPresenter.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation

protocol PokemonDetailPresenterInput {
    func presentPokemonDetail(_ pokemonDetail: PokemonDetail)
    func presentError(_ error: Error)
}

class PokemonDetailPresenter: PokemonDetailPresenterInput {
    weak var output: PokemonDetailPresenterOutput?
    
    func presentPokemonDetail(_ pokemonDetail: PokemonDetail) {
        output?.displayPokemonDetail(pokemonDetail)
    }
    
    func presentError(_ error: Error) {
        output?.displayError(error.localizedDescription)
    }
    
    
}
