//
//  Request.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import Foundation

class Request {
    
    static let textURL = "https://apiecho.cf/api/get/text/"
    static let signUpURL = "https://apiecho.cf/api/signup/"
    static let signInURL = "https://apiecho.cf/api/login/"
    
    static func getText(withToken token: String, parseText: @escaping ([String: Any]?, Error?) -> Void) {
        
        let urlRequest = Request.setValuesForRequest(toURL: URL(string: textURL)!, andToken: token, andParams: nil)
        _ = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if let error = error {
                parseText(nil, error)
            } else if let data = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        parseText(dic, nil)
                    }
                }
                catch (let error) {
                    parseText(nil, error)
                }
            }
        }.resume()
        
    }
    
    static func performAuthAction(withName name: String?, withEmail email: String, andPassword password: String, parseUser: @escaping ([String: Any]?, Error?) -> Void) {
        
        var params = [:] as Dictionary<String, String>
        var url: URL
        if let nameLogin = name {
            url = URL(string: signUpURL)!
            params = ["name": nameLogin, "email": email, "password": password]
        } else {
            url = URL(string: signInURL)!
            params = ["email": email, "password": password]
        }
        let urlRequest = Request.setValuesForRequest(toURL: url, andToken: nil, andParams: params)
        _ = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                parseUser(nil, error)
            }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    parseUser(json, nil)
                }
            } catch let error {
                parseUser(nil, error)
            }
        }.resume()
        
    }
    
    static func setValuesForRequest(toURL url: URL, andToken token: String?, andParams params: Dictionary<String, String>?) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        if (token != nil) {
            urlRequest.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        } else {
            urlRequest.httpMethod = "POST"
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return urlRequest
        
    }
    
}
