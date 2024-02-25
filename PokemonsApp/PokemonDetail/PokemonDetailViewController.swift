//
//  PokemonDetailViewController.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 22.02.24.
//

import Foundation
import UIKit

protocol PokemonDetailPresenterOutput: AnyObject {
    func displayPokemonDetail(_ pokemonDetail: PokemonDetail)
    func displayError(_ message: String)
}

class PokemonDetailViewController: UIViewController {
    
    let pokemonImageView = UIImageView()
    let pokemonNameLabel = UILabel()
    let pokemonTypeLabel = UILabel()
    let pokemonWeightLabel = UILabel()
    let pokemonHeightLabel = UILabel()
    
    var interactor: PokemonDetailInteractor?
    
    var worker = PokemonDetailWorker()
    private(set) var router: (PokemonDetailRoutingLogic & PokemonDetailDataPassingProtocol)?
    
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
        let presenter = PokemonDetailPresenter()
        let interactor = PokemonDetailInteractor()
        let router = PokemonDetailRouter()
        interactor.presenter = presenter
        presenter.output = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.dataPassing = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        interactor?.fetchPokemonDetail()
        interactor?.fetchDetail()
    }
}

extension PokemonDetailViewController: PokemonDetailPresenterOutput {
    func displayPokemonDetail(_ pokemonDetail: PokemonDetail) {
        print("height \(pokemonDetail.height), weight \(pokemonDetail.weight), type \(pokemonDetail.types.first?.type.name ?? "not type")")
        print(pokemonDetail.sprites.front_default)
        
        pokemonNameLabel.text = "Name: \(interactor?.pokemon.name ?? "default value")"
        pokemonTypeLabel.text = "Type: \(pokemonDetail.types.first?.type.name ?? "not type")"
        pokemonHeightLabel.text = "Height: \(pokemonDetail.height) cm."
        pokemonWeightLabel.text = "Weight: \(pokemonDetail.weight) kg."
    
        
        worker.fetchPokemonImage(from: pokemonDetail.sprites.front_default) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
    func displayError(_ message: String) {
        showAlert(title: "Sorry", message: "Pokemon does not found")
    }
}

extension PokemonDetailViewController {
    private func setupConstraints() {
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pokemonImageView)
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonTypeLabel)
        view.addSubview(pokemonHeightLabel)
        view.addSubview(pokemonWeightLabel)
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 40),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonNameLabel.heightAnchor.constraint(equalToConstant: 40),
            pokemonNameLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            pokemonTypeLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 40),
            pokemonTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            pokemonTypeLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            pokemonHeightLabel.topAnchor.constraint(equalTo: pokemonTypeLabel.bottomAnchor, constant: 40),
            pokemonHeightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonHeightLabel.heightAnchor.constraint(equalToConstant: 40),
            pokemonHeightLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            pokemonWeightLabel.topAnchor.constraint(equalTo: pokemonHeightLabel.bottomAnchor, constant: 40),
            pokemonWeightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonWeightLabel.heightAnchor.constraint(equalToConstant: 40),
            pokemonWeightLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
