//
//  ListViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ListViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var searchList: [TrendListModel] = []
    var genresDictionary: [Int: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        listCollectionView.register(UINib(nibName: ListCollectionViewCell.resueIdentifier, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.resueIdentifier)
        
        // genres IDs load
        requestTMDBMoiveList()
        
        //update Trend
        requestTMDBTrend(media_type: "all", time_window: "week")
        setCollectionViewLayout()
        
    }
    
    func requestTMDBTrend(media_type: String, time_window: String) {
        let url = "\(EndPoint.TMDBTrendURL)" + "\(media_type)/" + "\(time_window)?" + "api_key=\(APIKey.TMDB)"
        let imageURL = "https://image.tmdb.org/t/p/w500"
//        print(url)
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let image = imageURL + item["backdrop_path"].stringValue
                    let title = item["title"].stringValue
                    let release_date = item["release_date"].stringValue
                    let genre_ids = item["genre_ids"].arrayValue
                    var genreArray: [String] = []
                    
                    for target in genre_ids {
                        genreArray.append(self.genresDictionary[target.intValue] ?? "Etc")
                    }
                    
                    let overview = item["overview"].stringValue
                    let data = TrendListModel(release_date: release_date, genre_ids: genreArray, backdrop_path: image, title: title, overview: overview)
                    
                    self.searchList.append(data)
                }
                
                self.listCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTMDBMoiveList() {
        let url = "\(EndPoint.TMDBMovieListURL)" + "\(APIKey.TMDB)" + "&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let array = json["genres"].arrayValue
                
                for num in 0...(array.count - 1) {
                    let id = array[num]["id"].intValue
                    let name = array[num]["name"].stringValue
                    self.genresDictionary[id] = name
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width, height: height / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        listCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.resueIdentifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
//        cell.backgroundColor = .orange
        cell.listImageView.layer.cornerRadius = 10
        cell.preView.layer.cornerRadius = 10
        cell.configureCell(data: searchList[indexPath.row])
        
        return cell
    }
}
