//
//  TrendList.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/03.
//

import Foundation

struct TrendListModel {
    let release_date: String
    let genre_ids: [String]
    let backdrop_path: String
    let title: String
    let overview: String
    let poster_path: String
    let id: Int
}
