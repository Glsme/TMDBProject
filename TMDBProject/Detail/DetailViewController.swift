//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/04.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castTableView.delegate = self
        castTableView.dataSource = self
        
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
