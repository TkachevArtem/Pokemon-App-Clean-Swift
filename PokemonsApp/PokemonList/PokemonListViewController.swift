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
    
    let pokemonTableView = UITableView()
    let currentPageLabel = UILabel()
    let nextPageButton = UIButton()
    let previousPageButton = UIButton()
    
    let pokemonDetailVC = PokemonDetailViewController()
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
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupUIElements()
        setupTableView()
        
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        
        interactor?.fetchPokemons()
        
        nextPageButton.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
        previousPageButton.addTarget(self, action: #selector(previousPageButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func nextPageButtonTapped() {
        pokemons.removeAll()
        interactor?.loadNextPage()
        currentPageLabel.text = "\((interactor?.currentPage ?? 0) + 1)"
    }
    
    @objc private func previousPageButtonTapped() {
        pokemons.removeAll()
        interactor?.backToPreviousPage()
        currentPageLabel.text = "\((interactor?.currentPage ?? 0) + 1)"
    }
    
    private func setupUIElements() {
        currentPageLabel.text = "\((interactor?.currentPage ?? 0) + 1)"
        currentPageLabel.textAlignment = .center
        nextPageButton.setImage(UIImage(systemName: "arrowshape.forward.fill"), for: .normal)
        previousPageButton.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
    }
    
    private func setupTableView() {
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        pokemonTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
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
            router?.navigateToPokemonDetail(pokemon: pokemons[indexPath.row])
    }
}

extension PokemonListViewController {
    private func setupConstraints() {
        pokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        currentPageLabel.translatesAutoresizingMaskIntoConstraints = false
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        previousPageButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pokemonTableView)
        view.addSubview(currentPageLabel)
        view.addSubview(nextPageButton)
        view.addSubview(previousPageButton)
        
        NSLayoutConstraint.activate([
            currentPageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            currentPageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentPageLabel.widthAnchor.constraint(equalToConstant: 40),
            currentPageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nextPageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            nextPageButton.leadingAnchor.constraint(equalTo: currentPageLabel.trailingAnchor, constant: 20),
            nextPageButton.widthAnchor.constraint(equalToConstant: 40),
            nextPageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            previousPageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            previousPageButton.trailingAnchor.constraint(equalTo: currentPageLabel.leadingAnchor, constant: -20),
            previousPageButton.widthAnchor.constraint(equalToConstant: 40),
            previousPageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: currentPageLabel.topAnchor, constant: -10)
        ])
    }
}
