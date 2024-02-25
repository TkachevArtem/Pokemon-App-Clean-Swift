//
//  UIViewController.swift
//  PokemonsApp
//
//  Created by Artem Tkachev on 25.02.24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertControllec = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControllec.addAction(okAction)
        present(alertControllec, animated: true, completion: nil)
    }
}
