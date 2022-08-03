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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTMDB(media_type: "all", time_window: "week")

    }
    
    func requestTMDB(media_type: String, time_window: String) {
        let url = "\(EndPoint.TMDBURL)" + "\(media_type)/" + "\(time_window)?" + "api_key=\(APIKey.TMDB)"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }

}


