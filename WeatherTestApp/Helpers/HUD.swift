//
//  HUD.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import UIKit

class HUD {
    
    private static var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    private static var rootViewController: UIViewController? {
        appDelegate?.window?.rootViewController
    }
    
    private static var loader: LoaderViewController? {
        rootViewController?.presentedViewController as? LoaderViewController
    }
    
    static func show() {
        if loader != nil { return }
        let loaderView = LoaderViewController()
        loaderView.modalPresentationStyle = .fullScreen
        rootViewController?.present(loaderView, animated: false)
    }
    
    static func hide() {
        loader?.dismiss(animated: false)
    }
}
