//
//  Dictionary.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

extension Dictionary {
    
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[i]
        }
    }
    
}
