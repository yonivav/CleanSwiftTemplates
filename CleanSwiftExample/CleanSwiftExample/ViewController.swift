//
//  ViewController.swift
//  CleanSwiftExample
//
//  Created by Yoni Vizel on 10/30/20.
//

import UIKit

class ViewController: UIViewController {

    let loginViewController = LoginViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let storyboard = storyboard else { return }
        
        let loginViewController = storyboard.instantiateViewController(identifier: "loginSegue")
        present(loginViewController, animated: false)
    }
}

