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
        let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(page * 20)&limit=20"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                    return
        }
        
        if let cachedData = fetchCachedData(for: url) {
            do {
                let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: cachedData)
                completion(.success(pokemonListResponse.results))
            } catch {
                completion(.failure(error))
            }
        } else {
            AF.request(url).response { response in
                switch response.result {
                case .success(let data):
                    self.cacheResponseData(data: data!, for: url)
                    do {
                        let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data!)
                        completion(.success(pokemonListResponse.results))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func fetchCachedData(for url: URL) -> Data? {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let cachedResponse = cache.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
    
    private func cacheResponseData(data: Data, for url: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
    }
}

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

