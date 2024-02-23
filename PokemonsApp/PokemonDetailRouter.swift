//
//  PokemonDetailRouter.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 23.02.24.
//

import Foundation
import UIKit

protocol PokemonDetailRoutingLogic {
    
}

protocol PokemonDetailDataPassingProtocol {
    var dataPassing: PokemonDetailStoreProtocol? { get }
}

class PokemonDetailRouter: PokemonDetailRoutingLogic, PokemonDetailDataPassingProtocol {
    weak var dataPassing: PokemonDetailStoreProtocol?
}
