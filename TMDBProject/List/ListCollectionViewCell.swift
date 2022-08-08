//
//  ListCollectionViewCell.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(data: TrendListModel) {
        // font 적용
        hashTagLabel.font = UIFont(name: "Binggrae-Bold", size: 17)
        dateLabel.font = UIFont(name: "Binggrae", size: 13)
        titleLabel.font = UIFont(name: "Binggrae-Bold", size: 16)
        overViewLabel.font = UIFont(name: "Binggrae", size: 12)
        detailLabel.font = UIFont(name: "Binggrae", size: 12)
        
        listImageView.kf.setImage(with: URL(string: data.backdrop_path))
        dateLabel.text = data.release_date
        titleLabel.text = data.title
        overViewLabel.text = data.overview
        hashTagLabel.text = "#" + data.genre_ids.joined(separator: " #")
    }
    
//    @IBAction func clipButtonClicked(_ sender: UIButton) {
//        print(ListViewController.searchList[sender.tag].id)
//        requestTMDBMovieLink(movieId: ListViewController.searchList[sender.tag].id)
//    }
}
