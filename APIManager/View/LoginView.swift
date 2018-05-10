//
//  LoginView.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    
    var startViewController: LoginViewController?
    
    let signInTextView: UITextView = {
        let textView = UITextView()
        textView.setDefaultTextViewParams(withText: "Please sign in")
        return textView
    }()
    
    let signUpTextView: UITextView = {
        let textView = UITextView()
        textView.setDefaultTextViewParams(withText: "Please sign up")
        textView.alpha = 0
        return textView
        
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(LoginViewController.buttonPressed), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign up", for: .normal)
        button.addTarget(self, action: #selector(signUpNeeded), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.setDefaultTextFieldParams(withPlaceholder: "Enter your name")
        textField.alpha = 0
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.setDefaultTextFieldParams(withPlaceholder: "Enter your email")
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setDefaultTextFieldParams(withPlaceholder: "Enter your password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubviews(views: signInTextView, signUpTextView, nameTextField, emailTextField, passwordTextField, loginButton, signUpButton)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupConstraints()
    }
    
    @objc func signUpNeeded() {
        
        if (signUpTextView.alpha == 0) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                self?.emailTextField.text = ""
                self?.passwordTextField.text = ""
                self?.signInTextView.alpha = 0
                self?.signUpTextView.alpha = 1
                self?.nameTextField.alpha = 1
                self?.loginButton.setTitle("Sign up", for: .normal)
                self?.signUpButton.setTitle("Return", for: .normal)
                }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                self?.emailTextField.text = ""
                self?.passwordTextField.text = ""
                self?.nameTextField.text = ""
                self?.signInTextView.alpha = 1
                self?.signUpTextView.alpha = 0
                self?.nameTextField.alpha = 0
                self?.loginButton.setTitle("Sign in", for: .normal)
                self?.signUpButton.setTitle("Sign up", for: .normal)
                }, completion: nil)
        }
        
    }
    
    func setupConstraints() {
        signUpTextView.anchorWithConstantsToTop(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        signInTextView.anchorWithConstantsToTop(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        nameTextField.anchorWithConstantsToTop(top: signInTextView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 50, bottomConstant: 0, rightConstant: 50)
        nameTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        emailTextField.anchorWithConstantsToTop(top: nameTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 50, bottomConstant: 0, rightConstant: 50)
        emailTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        passwordTextField.anchorWithConstantsToTop(top: emailTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 50, bottomConstant: 0, rightConstant: 50)
        passwordTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        loginButton.anchorWithConstantsToTop(top: passwordTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 50, bottomConstant: 0, rightConstant: 50)
        signUpButton.anchorWithConstantsToTop(top: loginButton.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 80, bottomConstant: 0, rightConstant: 80)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == nameTextField) {
            emailTextField.becomeFirstResponder()
        } else if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if (textField == passwordTextField) {
            startViewController?.buttonPressed()
            endEditing(true)
        }
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
