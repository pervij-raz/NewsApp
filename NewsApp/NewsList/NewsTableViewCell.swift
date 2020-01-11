//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Methods
    
    func setup(with article: Article) {
        let url = URL(string: article.imageURl ?? "")
        newsImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], context: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        if article.date != nil {
            dateLabel.text = dateFormatter.string(from: article.date!)
        }
        titleLabel.text = article.title ?? ""
    }
    
}
