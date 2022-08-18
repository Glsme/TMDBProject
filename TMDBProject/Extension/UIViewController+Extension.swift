//
//  UIViewController+Extension.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/18.
//

import UIKit

extension UIViewController {
    
    enum Transition {
        case push
        case present
    }
    
    func transitionViewController<T: UIViewController>(storyboard: String, viewController vc: T, transition: Transition) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        
        switch transition {
        case .present:
            self.present(controller, animated: true)
        case .push:
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
