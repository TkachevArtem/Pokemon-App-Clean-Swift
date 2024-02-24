//
//  PokemonDetailWorker.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation
import Alamofire

class PokemonDetailWorker {
    
    //private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func fetchPokemonDetail(pokemonURL: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        //let url = baseURL + "\(pokemonID)"
        let url = pokemonURL
        AF.request(url).responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let pokemonDetailResponse):
                completion(.success(pokemonDetailResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemonImage(from pokemonImageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.request(pokemonImageURL).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkError.invalidImageData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidImageData
}
