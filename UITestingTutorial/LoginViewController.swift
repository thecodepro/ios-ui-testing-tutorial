//
//  LoginViewController.swift
//  UITestingTutorial
//
//  Created by Code Pro on 9/14/18.
//  Copyright © 2018 Code Pro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    let expectedUserName = "CodePro"
    let expectedPassword = "abc123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        password.delegate = self
        navigationBar.delegate = self
        statusLabel.text = ""
        loadingActivity.hidesWhenStopped = true
    }
    
    @IBAction func login(_ sender: Any) {
        
        statusLabel.text = "Logging In"
        
        loadingActivity.startAnimating()
        
        guard let userName = userName.text, !userName.isEmpty,
            let password = password.text, !password.isEmpty else {
                presentAlert(with: "Missing Credentials", message: "Missing User Name Or Password")
                return
        }
        
        guard expectedUserName == userName else {
            presentAlert(with: "Invalid Credentials", message: "Invalid User Name")
            return
        }
        
        guard expectedPassword == password else {
            presentAlert(with: "Invalid Credentials", message: "Invalid Password")
            return
        }
        
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.statusLabel.text = "Logged In"
            self.loadingActivity.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func presentAlert(with title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
 
        alertVC.addAction(.init(title: "Ok", style: .default, handler: nil))

        present(alertVC, animated: true, completion: nil)
    }
}

extension LoginViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
