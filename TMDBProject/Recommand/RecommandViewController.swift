//
//  RecommandViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/09.
//

import UIKit

class RecommandViewController: UIViewController {

    @IBOutlet weak var recommandTableView: UITableView!
    
    var recommandList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recommandTableView.delegate = self
        recommandTableView.dataSource = self
        
        TMDBMovieAPIManager.shared.callRequestRecommand { value in
            self.recommandList = value
            self.recommandTableView.reloadData()
            dump(self.recommandList)
        }
    }
}

extension RecommandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recommandList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommandTableViewCell.reuseIdentifier, for: indexPath) as? RecommandTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .green
        cell.recommandCollectionView.backgroundColor = .lightGray
        cell.recommandCollectionView.delegate = self
        cell.recommandCollectionView.dataSource = self
        cell.recommandCollectionView.tag = indexPath.section
        cell.recommandCollectionView.register(UINib(nibName: RecommandCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: RecommandCollectionViewCell.reuseIdentifier)
        
        cell.recommandCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(recommandList[collectionView.tag].count)
        return recommandList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: "\(EndPoint.TMDBImageURL)\(recommandList[collectionView.tag][indexPath.item])")
        
        cell.cardView.posterImageView.kf.setImage(with: url)

        
        return cell
    }
    
    
}
