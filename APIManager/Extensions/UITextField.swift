//
//  UITextField.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setDefaultTextFieldParams(withPlaceholder placeholder: String) {
        self.placeholder = placeholder
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.autocorrectionType = UITextAutocorrectionType.no
        self.clearsOnBeginEditing = true
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2
        self.setLeftPaddingPoints(10)
    }
    
}
