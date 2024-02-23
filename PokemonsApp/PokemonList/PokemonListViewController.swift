//
//  ViewController.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 20.02.24.
//

import UIKit

protocol PokemonListPresenterOutput: AnyObject {
    func displayPokemons(_ pokemons: [Pokemon])
    func displayError(_ message: String)
}

class PokemonListViewController: UIViewController {
    
    let pokemonDetailVC = PokemonDetailViewController()
    let pokemonTableView = UITableView()
    var interactor: PokemonListInteractor?
    private(set) var router: PokemonRoutingLogic?
    var worker = PokemonListWorker()
    
    var pokemons: [Pokemon] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    func setup() {
        let viewController = self
        let presenter = PokemonListPresenter()
        let interactor = PokemonListInteractor()
        let router = PokemonRouter()
        interactor.presenter = presenter
        presenter.output = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    
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
        
        interactor?.fetchPokemons()
        
    }
}

extension PokemonListViewController: PokemonListPresenterOutput {
    func displayPokemons(_ pokemons: [Pokemon]) {
        self.pokemons.append(contentsOf: pokemons)
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
            interactor?.loadNextPage()
        } else {
            router?.navigateToPokemonDetail(pokemonId: 5)
        }
    }
}

