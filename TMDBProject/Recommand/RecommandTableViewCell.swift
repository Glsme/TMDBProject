//
//  RecommandTableViewCell.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/09.
//

import UIKit

class RecommandTableViewCell: UITableViewCell {

    @IBOutlet weak var recommandCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setupUI() {
        recommandCollectionView.backgroundColor = .clear
        recommandCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return layout
    }
}
