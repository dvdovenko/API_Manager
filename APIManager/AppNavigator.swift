//
//  AppNavigator.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

class AppNavigator {
    
    static func initStartingWindow(_ window: UIWindow?, startViewController controller: UIViewController) {
        
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        
    }
    
}
