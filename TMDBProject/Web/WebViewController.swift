//
//  WebViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/07.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var youtubeLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: youtubeLink)
    }
    
    func openWebPage(url: String) {
        print(url)
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
