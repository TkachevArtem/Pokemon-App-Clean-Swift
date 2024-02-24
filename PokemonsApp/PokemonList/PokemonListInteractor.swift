//
//  PokemonListInteractor.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 20.02.24.
//

import Foundation


class PokemonListInteractor {
    
    var presenter: PokemonListPresenterInput?
    let worker = PokemonListWorker()
    var currentPage = 0
    
    func fetchPokemons() {
        worker.fetchPokemons(page: currentPage) { result in
            switch result {
            case .success(let pokemons):
                self.presenter?.presentPokemons(pokemons)
            case .failure(let error):
                print(error)
                self.presenter?.presentError(error)
            }
        }
    }
    
    func loadNextPage() {
        if currentPage < 65 {
            currentPage += 1
            fetchPokemons()
        }
    }
    
    func backToPreviousPage() {
        if currentPage > 0 {
            currentPage -= 1
            fetchPokemons()
        }
    }
}
