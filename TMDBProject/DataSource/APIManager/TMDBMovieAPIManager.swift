//
//  APIManager.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBMovieAPIManager {
    
    static let shared = TMDBMovieAPIManager()
    var moiveNameList: [String] = []
    
    private init() { }
    
    func requestRecommand(movieId: Int, completionHandeler: @escaping ( [String]) -> () ) {
        let url = "\(EndPoint.TMDBMovieRecommandURL)\(movieId)/recommendations?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"

        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print(json)
                
                let value = json["results"].arrayValue.map{ $0["poster_path"].stringValue }
//                print(value)
                
                completionHandeler(value)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestRecommand(completionHandler: @escaping ( [[String]]) -> () ) {
        
        var posterList: [[String]] = []
        
        TMDBMovieAPIManager.shared.requestRecommand(movieId: ListViewController.searchList[0].id) { value in
            posterList.append(value)
            self.moiveNameList.append(ListViewController.searchList[0].title)
            
            TMDBMovieAPIManager.shared.requestRecommand(movieId: ListViewController.searchList[2].id) { value in
                posterList.append(value)
                self.moiveNameList.append(ListViewController.searchList[2].title)
                
                TMDBMovieAPIManager.shared.requestRecommand(movieId: ListViewController.searchList[4].id) { value in
                    posterList.append(value)
                    self.moiveNameList.append(ListViewController.searchList[4].title)
                    
                    TMDBMovieAPIManager.shared.requestRecommand(movieId: ListViewController.searchList[6].id) { value in
                        posterList.append(value)
                        self.moiveNameList.append(ListViewController.searchList[6].title)
                        
                        TMDBMovieAPIManager.shared.requestRecommand(movieId: ListViewController.searchList[7].id) { value in
                            posterList.append(value)
                            self.moiveNameList.append(ListViewController.searchList[7].title)
                            
//                            print(self.moiveNameList)
                            completionHandler(posterList)
                        }
                    }
                }
            }
        }
    }
}
