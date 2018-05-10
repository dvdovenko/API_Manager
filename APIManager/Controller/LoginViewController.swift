//
//  LoginViewController.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    let containerForActivityIndicator: UIView = {
        let container = UIView()
        container.backgroundColor = .lightCharcoal
        return container
    }()
    
    let loadingViewForActivityIndicator: UIView = {
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.backgroundColor = .charcoal
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        return activityIndicator
    }()
    
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var user: User? {
        didSet {
            guard let token = user?.token else { return }
            Request.getText(withToken: token) { [weak self] (data, error) in
                guard error == nil else {
                    self?.showWarning(withText: error?.localizedDescription ?? "Something went wrong", withActivityIndicator: true)
                    return
                }
                guard let json = data else {
                    self?.showWarning(withText: "Problems with data", withActivityIndicator: true)
                    return
                }
                guard let text = json["data"] as? String else { return }
                let resultTableViewController = ResultTableViewController(style: UITableViewStyle.plain)
                resultTableViewController.text = text
                DispatchQueue.main.async { [weak self] in
                    self?.view.hideActivityIndicatory(inContainer: self?.containerForActivityIndicator, inLoadingView: self?.loadingViewForActivityIndicator, andActivityIndicator: self?.activityIndicator)
                    self?.navigationController?.pushViewController(resultTableViewController, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loginView.startViewController = self
        navigationItem.title = "Home"
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg")!)
        view.addSubview(loginView)
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if (notification.name == NSNotification.Name.UIKeyboardWillShow || notification.name == NSNotification.Name.UIKeyboardWillChangeFrame) {
            view.frame.origin.y = -keyboardSize.height / 3
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func showWarning(withText text: String, withActivityIndicator activity: Bool) {
        if (activity == true) {
            DispatchQueue.main.async { [weak self] in
                self?.view.hideActivityIndicatory(inContainer: self?.containerForActivityIndicator, inLoadingView: self?.loadingViewForActivityIndicator, andActivityIndicator: self?.activityIndicator)
            }
        }
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func buttonPressed() {
        view.frame.origin.y = 0
        var name: String? = nil
        if (loginView.nameTextField.alpha == 1) {
            name = loginView.nameTextField.text
            guard name != "" else {
                showWarning(withText: "Name field cannot be empty", withActivityIndicator: false)
                return
            }
        }
        guard let email = loginView.emailTextField.text, email != "" else {
            showWarning(withText: "Email field cannot be empty", withActivityIndicator: false)
            return
        }
        guard let password = loginView.passwordTextField.text, password != "" else {
            showWarning(withText: "Password field cannot be empty", withActivityIndicator: false)
            return
        }
        view.showActivityIndicatory(inContainer: containerForActivityIndicator, inLoadingView: loadingViewForActivityIndicator, andActivityIndicator: activityIndicator)
        Request.performAuthAction(withName: name, withEmail: email, andPassword: password) { [weak self] (data, error) in
            guard error == nil else {
                self?.showWarning(withText: error?.localizedDescription ?? "Something went wrong", withActivityIndicator: true)
                return
            }
            let json = JSON(data as Any)
            let warning = json["errors"][0]["message"].stringValue
            guard warning == "" else {
                self?.showWarning(withText: warning, withActivityIndicator: true)
                return
            }
            self?.user = User(name: json["data"]["name"].stringValue, email: email, token: json["data"]["access_token"].stringValue)
        }
    }
    
    func setupConstraints() {
        loginView.heightAnchor.constraint(equalToConstant: 290).isActive = true
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
}

