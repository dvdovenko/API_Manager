//
//  NavigationBarSetup.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

class NavigationBarSetup {
    static func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.teal
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
