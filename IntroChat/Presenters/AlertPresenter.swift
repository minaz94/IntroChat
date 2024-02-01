//
//  AlertPresenter.swift
//  IntroChat
//
//  Created by Mina on 1/30/24.
//

import UIKit


class AlertPresenter {
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func showAlert(title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { action in
            alert.addAction(action)
        }
        navigationController?.present(alert, animated: true)
    }
    
}
