//
//  UIView.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
    }
    
    func showActivityIndicatory(inContainer container: UIView?, inLoadingView loadingView: UIView?, andActivityIndicator activityIndicator: UIActivityIndicatorView?) {
        guard let container = container else { return }
        guard let loadingView = loadingView else { return }
        guard let activityIndicator = activityIndicator else { return }
        container.alpha = 0
        loadingView.alpha = 0
        activityIndicator.alpha = 0
        container.frame = self.frame
        container.center = self.center
        loadingView.center = self.center
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.addSubview(container)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            container.alpha = 1
            loadingView.alpha = 1
            activityIndicator.alpha = 1
        }, completion: nil)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicatory(inContainer container: UIView?, inLoadingView loadingView: UIView?, andActivityIndicator activityIndicator: UIActivityIndicatorView?) {
        guard let container = container else { return }
        guard let loadingView = loadingView else { return }
        guard let activityIndicator = activityIndicator else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            container.alpha = 0
            loadingView.alpha = 0
            activityIndicator.alpha = 0
        }, completion: nil)
        container.removeFromSuperview()
        loadingView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
