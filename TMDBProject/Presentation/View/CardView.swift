//
//  CardView.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/09.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
        
//        fatalError("init(coder:) has not been implemented")
    }
}
