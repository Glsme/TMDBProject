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
            print("!!!!", value)
        }
    }
}

extension RecommandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommandTableViewCell.reuseIdentifier, for: indexPath) as? RecommandTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .green
        cell.recommandCollectionView.backgroundColor = .lightGray
        cell.recommandCollectionView.delegate = self
        cell.recommandCollectionView.dataSource = self
        cell.recommandCollectionView.tag = indexPath.section
        cell.recommandCollectionView.register(UINib(nibName: RecommandCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: RecommandCollectionViewCell.reuseIdentifier)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
