//
//  UITextView.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

extension UITextView {
    
    func setDefaultTextViewParams(withText text: String) {
        self.text = text
        self.backgroundColor = UIColor.clear
        self.font = .boldSystemFont(ofSize: 18)
        self.textAlignment = .center
        self.isEditable = false
        self.isScrollEnabled = false
    }
    
}

