//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var casts: [MovieCastModel] = []
    var list: [String] = []
    var data = TrendListModel(release_date: "", genre_ids: [], backdrop_path: "", title: "", overview: "", poster_path: "", id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(UINib(nibName: CastTableViewCell.resueIdentifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.resueIdentifier)
        
        configureUI(data: data)
        requestTMDBCast(id: data.id)
    }
    
    func configureUI(data: TrendListModel) {
        backImageView.kf.setImage(with: URL(string: data.backdrop_path))
        posterImageView.kf.setImage(with: URL(string: data.poster_path))
        titleLabel.text = data.title
        overViewLabel.text = data.overview
    }
    
    func requestTMDBCast(id: Int) {
        
        list.removeAll()
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.TMDB)&language=en-US"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                for personInfo in json["cast"].arrayValue {
                    guard let job = personInfo["known_for_department"].string else { return }
                    
                    if job == "Acting" {
                        let profilePath = EndPoint.TMDBImageURL + personInfo["profile_path"].stringValue
                        let name = personInfo["name"].stringValue
                        let original_name = personInfo["original_name"].stringValue
                        let id = personInfo["id"].intValue
                        
                        let data = MovieCastModel(name: name,originalName: original_name, profilePath: profilePath, id: id)
                        
                        self.casts.append(data)
                    }
                }
                
//                print(self.casts)
                
                self.castTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.resueIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = casts[indexPath.row].name
        cell.profileImageView.layer.cornerRadius = 20
        cell.profileImageView.kf.setImage(with: URL(string: casts[indexPath.row].profilePath))
        cell.detailLabel.text = "\(casts[indexPath.row].originalName) / \"No.\(casts[indexPath.row].id)\""
        
        return cell
    }
}
