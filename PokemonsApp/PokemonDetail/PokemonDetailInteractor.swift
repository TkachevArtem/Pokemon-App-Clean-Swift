//
//  PokemonDetailInteractor.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation
import Alamofire

protocol PokemonDetailStoreProtocol: AnyObject {
    var pokemon: Pokemon { get set }
}

class PokemonDetailInteractor: PokemonDetailStoreProtocol {
    
    var presenter: PokemonDetailPresenterInput?
    let worker = PokemonDetailWorker()
    var pokemon: Pokemon = Pokemon(name: "Test Name", url: "Test URL")
    
    func fetchPokemonDetail() {
        worker.fetchPokemonDetail(pokemonURL: pokemon.url) { result in
            switch result {
            case .success(let pokemonDetail):
                self.presenter?.presentPokemonDetail(pokemonDetail)
            case .failure(let error):
                self.presenter?.presentError(error)
            }
        }
    }
    
    func fetchDetail() {
        print(pokemon.name)
    }
}


