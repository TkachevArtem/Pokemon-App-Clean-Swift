//
//  PokemonListWorker.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 21.02.24.
//

import Foundation
import Alamofire

class PokemonListWorker {
    
    func fetchPokemons(page: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon?offset=\(page * 20)&limit=20"
        AF.request(url).responseDecodable(of: PokemonListResponse.self) { response in
            switch response.result {
            case .success(let pokemonListResponse):
                completion(.success(pokemonListResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

