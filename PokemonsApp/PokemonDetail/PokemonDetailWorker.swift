//
//  PokemonDetailWorker.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation
import Alamofire

class PokemonDetailWorker {
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        let url = baseURL + "\(pokemonID)"
        AF.request(url).responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let pokemonDetailResponse):
                completion(.success(pokemonDetailResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

