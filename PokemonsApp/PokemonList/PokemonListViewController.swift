//
//  ViewController.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 20.02.24.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    let pokemonTableView = UITableView()
    
    var interactor = PokemonListInteractor()
    var pokemons: [Pokemon] = []
    
    var worker = PokemonListWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        pokemonTableView.frame = view.bounds
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        pokemonTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        view.addSubview(pokemonTableView)
        
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        
        interactor.fetchPokemons()
        
    }
}

extension PokemonListViewController: PokemonListPresenterOutput {
    func displayPokemons(_ pokemons: [Pokemon]) {
        for i in pokemons {
            print(i)
        }
//        self.pokemons.append(contentsOf: pokemons)
        for i in pokemons {
            self.pokemons.append(i)
//            self.pokemonTableView.reloadData()
        }
        pokemonTableView.reloadData()
    }
    
    func displayError(_ message: String) {
        print(message)
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let displayedPokemon = pokemons[indexPath.row]
        cell.textLabel?.text = displayedPokemon.name
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            interactor.loadNextPage()
        }
    }
}

