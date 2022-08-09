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
    var crews: [MovieCrewModel] = []
    var list: [String] = []
    var data = TrendListModel(release_date: "", genre_ids: [], backdrop_path: "", title: "", overview: "", poster_path: "", id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(UINib(nibName: CastTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
        castTableView.register(UINib(nibName: OverViewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        
        configureUI(data: data)
        requestTMDBCast(id: data.id)
    }
    
    func configureUI(data: TrendListModel) {
        backImageView.kf.setImage(with: URL(string: data.backdrop_path))
        posterImageView.kf.setImage(with: URL(string: data.poster_path))
        titleLabel.text = data.title
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
                
                for personInfo in json["crew"].arrayValue {
                    let profilePath = EndPoint.TMDBImageURL + personInfo["profile_path"].stringValue
                    let name = personInfo["name"].stringValue
                    let known_for_department = personInfo["known_for_department"].stringValue
                    
                    let data = MovieCrewModel(profilePath: profilePath, name: name, knownForDepartment: known_for_department)
                    
                    self.crews.append(data)
                }
                
//                print(self.casts)
                
                // TableView 갱신
                self.castTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else if section == 1 {
            return "Cast"
        } else if section == 2 {
            return "Crew"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.15
        } else {
            return UIScreen.main.bounds.height * 0.125
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return casts.count
        } else if section == 2 {
            return crews.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let overviewCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
            
            overviewCell.configureCell()
            
            overviewCell.overViewLabel.text = data.overview
            
            return overviewCell
        } else if indexPath.section == 1 {
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            castCell.configureCell()
            
            castCell.nameLabel.text = casts[indexPath.row].name
            castCell.profileImageView.layer.cornerRadius = 10
            castCell.profileImageView.kf.setImage(with: URL(string: casts[indexPath.row].profilePath))
            castCell.detailLabel.text = "\(casts[indexPath.row].originalName) / \"No.\(casts[indexPath.row].id)\""
            return castCell
        } else if indexPath.section == 2 {
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            castCell.configureCell()
            
            castCell.nameLabel.text = crews[indexPath.row].name
            castCell.profileImageView.layer.cornerRadius = 10
            castCell.profileImageView.kf.setImage(with: URL(string: crews[indexPath.row].profilePath))
            castCell.detailLabel.text = crews[indexPath.row].knownForDepartment
            return castCell
        }
        
        else {
            return UITableViewCell()
        }


    }
}
