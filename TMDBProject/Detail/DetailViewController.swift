//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/04.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var data = TrendListModel(release_date: "", genre_ids: [], backdrop_path: "", title: "", overview: "", poster_path: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(UINib(nibName: CastTableViewCell.resueIdentifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.resueIdentifier)
        
        configureUI(data: data)
    }
    
    func configureUI(data: TrendListModel) {
        backImageView.kf.setImage(with: URL(string: data.backdrop_path))
        posterImageView.kf.setImage(with: URL(string: data.poster_path))
        titleLabel.text = data.title
        overViewLabel.text = data.overview
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.resueIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
