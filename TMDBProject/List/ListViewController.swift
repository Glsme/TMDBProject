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
    var startPage = 1
    var totalCount = 0
    var mediaType = "movie"
    var timeWindow = "day"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.prefetchDataSource = self // Pagenation
        
        listCollectionView.register(UINib(nibName: ListCollectionViewCell.resueIdentifier, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.resueIdentifier)
        
        // genres IDs load
        requestTMDBMoiveList()
        
        //update Trend
        requestTMDBTrend(media_type: mediaType, time_window: timeWindow, page: startPage)
        setCollectionViewLayout()
        
    }
    
    // Movie & TV 적용
    func requestTMDBTrend(media_type: String, time_window: String, page: Int) {
        let url = "\(EndPoint.TMDBTrendURL)" + "\(media_type)/" + "\(time_window)?" + "api_key=\(APIKey.TMDB)" + "&page=\(page)"
//        print(url)
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.totalCount = json["total_results"].intValue
                
                for item in json["results"].arrayValue {
                    let image = EndPoint.TMDBImageURL + item["backdrop_path"].stringValue
                    let title = item["original_title"].string ?? item["original_name"].stringValue
                    let release_date = item["release_date"].string ?? item["first_air_date"].stringValue
                    let genre_ids = item["genre_ids"].arrayValue
                    let poster_path = EndPoint.TMDBImageURL + item["poster_path"].stringValue
                    let id = item["id"].intValue
                    var genreArray: [String] = []
                    
                    for target in genre_ids {
                        genreArray.append(self.genresDictionary[target.intValue] ?? "Etc")
                    }
                    
                    let overview = item["overview"].stringValue
                    let data = TrendListModel(release_date: release_date, genre_ids: genreArray, backdrop_path: image, title: title, overview: overview, poster_path: poster_path, id: id)
                    
                    self.searchList.append(data)
                }
                
//                self.totalCount = self.searchList.count
                self.listCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTMDBMoiveList() {
        let url = "\(EndPoint.TMDBMovieListURL)" + "\(APIKey.TMDB)" + "&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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

// Pagenation
extension ListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchList.count - 5 == indexPath.item && searchList.count < totalCount {
                startPage += 1
                requestTMDBTrend(media_type: mediaType, time_window: timeWindow, page: startPage)
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
        layout.itemSize = CGSize(width: width, height: height / 2.35)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = 10
        listCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.resueIdentifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.preView.layer.shadowColor = UIColor.black.cgColor
        cell.preView.layer.masksToBounds = false
        cell.preView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.preView.layer.shadowRadius = 5
        cell.preView.layer.shadowOpacity = 0.3
        
//        cell.backgroundColor = .orange
        cell.listImageView.layer.cornerRadius = 10
        cell.listImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.preView.layer.cornerRadius = 10
        
        cell.clipButton.layer.cornerRadius = cell.clipButton.frame.height / 2
        
        cell.configureCell(data: searchList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.resueIdentifier) as? DetailViewController else { return }
        
        vc.data = searchList[indexPath.row]
        
        vc.navigationItem.title = "출연/제작"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
