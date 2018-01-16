//
//  LoginViewController.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Alertable {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defineText()
    }
    
    
    //MARK: - Private methods
    
    private func setupInterface() {
        emailTextField.delegate = self
        defineText()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func defineText() {
        emailTextField.text = DataManager.instance.email ?? ""
    }
    
    @objc private func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    private func hideKeyboard() {
        view.endEditing(true)
    }
    private func setEmail(_ email: String) {
        DataManager.instance.setEmail(email: email)
        performSegue(withIdentifier: "Favorites", sender: self)
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        if email.isEmpty {
            showAlert(title: "Enter your email")
        } else {
            email.isEmailValid ? setEmail(email) : showAlert(title: "Incorrect format")
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
