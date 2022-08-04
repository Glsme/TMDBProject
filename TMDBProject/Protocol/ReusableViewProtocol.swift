//
//  ReusableViewProtocol.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

protocol ReusableProtocol {
    static var resueIdentifier: String { get }
}

extension UICollectionViewCell: ReusableProtocol {
    static var resueIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol {
    static var resueIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var resueIdentifier: String {
        return String(describing: self)
    }
}
