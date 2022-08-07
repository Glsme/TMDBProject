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
    static var youtubeLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPage()
    }
    
    func openWebPage() {
        guard let url = URL(string: WebViewController.youtubeLink) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
