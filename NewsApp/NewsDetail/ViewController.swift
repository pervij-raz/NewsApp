//
//  ViewController.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var url: URL?
    var titleText: String?
    var descriptionText: String?
    var articleDate: String?
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func openLinkButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = articleDate
         articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], context: nil)
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }

    func setup(with article: Article) {
        url = URL(string: article.imageURl ?? "")
        titleText = article.title
        descriptionText = article.articleDescription
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        if article.date != nil {
            articleDate = dateFormatter.string(from: article.date!)
        }
    }

}

