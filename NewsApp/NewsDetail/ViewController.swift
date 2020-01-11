//
//  ViewController.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: Properties
    
    private var url: URL?
    private var titleText: String?
    private var descriptionText: String?
    private var articleDate: String?
    private var articleURL: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Methods
    
    @IBAction func openLinkButton(_ sender: UIButton) {
        let webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        guard let url = URL(string: articleURL ?? "") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
    
    func setup(with article: Article) {
        url = URL(string: article.imageURl ?? "")
        titleText = article.title
        descriptionText = article.articleDescription
        articleURL = article.articleURL
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        if article.date != nil {
            articleDate = dateFormatter.string(from: article.date!)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = articleDate
        articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], context: nil)
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
    
}

