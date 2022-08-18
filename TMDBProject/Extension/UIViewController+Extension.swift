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
    
    func transitionViewController<T: UIViewController>(storyboard: String, viewController vc: T, transition: Transition, completionHandler: (T) -> ()?) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        
        switch transition {
        case .present:
            completionHandler(controller)
            self.present(controller, animated: true)
        case .push:
            completionHandler(controller)
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
}
