//
//  PokemonListPresenter.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 20.02.24.
//

import Foundation

protocol PokemonListPresenterInput {
    func presentPokemons(_ pokemons: [Pokemon])
    func presentError(_ error: Error)
}

protocol PokemonListPresenterOutput: AnyObject {
    func displayPokemons(_ pokemons: [Pokemon])
    func displayError(_ message: String)
}

class PokemonListPresenter: PokemonListPresenterInput {
    weak var output: PokemonListPresenterOutput?
    
    func presentPokemons(_ pokemons: [Pokemon]) {
        output?.displayPokemons(pokemons)
    }
    
    func presentError(_ error: Error) {
        output?.displayError(error.localizedDescription)
    }
}
