//
//  ListCollectionViewCell.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

import Kingfisher

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var clipButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(data: TrendListModel) {
        listImageView.kf.setImage(with: URL(string: data.backdrop_path))
        dateLabel.text = data.release_date
        titleLabel.text = data.title
        overViewLabel.text = data.overview
        hashTagLabel.text = "#" + data.genre_ids.joined(separator: " #")
    }
    
    @IBAction func clipButtonClicked(_ sender: Any) {
    }
    
}
