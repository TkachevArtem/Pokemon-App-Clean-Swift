//
//  PokemonRouter.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 23.02.24.
//

import Foundation
import UIKit

protocol PokemonRoutingLogic {
    func navigateToPokemonDetail(pokemonId: Int)
}

class PokemonRouter: PokemonRoutingLogic {
    
    weak var viewController: PokemonListViewController?
    
    func navigateToPokemonDetail(pokemonId: Int) {
        guard let pokemonDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else { return }
        pokemonDetailVC.router?.dataPassing?.pokemonID = pokemonId
        viewController?.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
}
