//
//  CastTableViewCell.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/04.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        nameLabel.font = UIFont(name: "Binggrae-Bold", size: 17)
        detailLabel.font = UIFont(name: "Binggrae", size: 13)
    }
    
}
