//
//  UIViewController+Extension.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/18.
//

import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storyboard: String, viewController vc: T) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        self.present(controller, animated: true)
    }
    
    func pushViewController<T: UIViewController>(storyboard: String, viewController vc: T) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        print(String(describing: vc))
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
