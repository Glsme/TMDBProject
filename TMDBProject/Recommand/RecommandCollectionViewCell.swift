//
//  RecommandCollectionViewCell.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/09.
//

import UIKit

class RecommandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .blue
//        cardView.posterImageView.layer.cornerRadius = 10
        cardView.posterImageView.tintColor = .systemPink
    }
}
