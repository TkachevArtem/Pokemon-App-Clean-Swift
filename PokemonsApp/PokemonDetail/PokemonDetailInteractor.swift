//
//  PokemonDetailInteractor.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation

class PokemonDetailInteractor {
    
    var presenter: PokemonDetailPresenterInput?
    let worker = PokemonDetailWorker()
    var pokemonID = 2
    
    func fetchPokemonDetail() {
        worker.fetchPokemonDetail(pokemonID: pokemonID) { result in
            switch result {
            case .success(let pokemonDetail):
                self.presenter?.presentPokemonDetail(pokemonDetail)
            case .failure(let error):
                print(error)
                self.presenter?.presentError(error)
            }
        }
    }
}
