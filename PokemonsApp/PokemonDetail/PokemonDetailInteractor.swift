//
//  PokemonDetailInteractor.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation

protocol PokemonDetailStoreProtocol: AnyObject {
    //var pokemon: Pokemon { get set }
    var pokemonID: Int { get set }
}

class PokemonDetailInteractor: PokemonDetailStoreProtocol {
    
    var presenter: PokemonDetailPresenterInput?
    let worker = PokemonDetailWorker()
    var pokemonID = 2
    //var pokemon: Pokemon = Pokemon(name: "Test")
    
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
    
    func fetchDetail() {
        print(pokemonID)
    }
}
