//
//  IntroViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/16.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        startLabel.font = UIFont(name: "Binggrae-Bold", size: 17)
        startButton.titleLabel?.font = UIFont(name: "Binggrae-Bold", size: 17)
    }

    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "First")
        
        let sb = UIStoryboard(name: StoryboardName.List.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ListViewController.reuseIdentifier) as? ListViewController else { return }
        
//        self.modalPresentationStyle = .fullScreen
//        dismiss(animated: true)
    }
}
