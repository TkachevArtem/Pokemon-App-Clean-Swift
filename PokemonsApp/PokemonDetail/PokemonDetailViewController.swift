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
    
    var interactor: PokemonDetailInteractor?
    //var pokemonDetail: [PokemonDetail] = []
    
    var worker = PokemonDetailWorker()
    
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
        interactor.presenter = presenter
        presenter.output = viewController
        viewController.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchPokemonDetail()
    }
}

extension PokemonDetailViewController: PokemonDetailPresenterOutput {
    func displayPokemonDetail(_ pokemonDetail: PokemonDetail) {
        print("height \(pokemonDetail.height), weight \(pokemonDetail.weight)")
    }
    
    func displayError(_ message: String) {
        print(message)
    }
    
    
}
