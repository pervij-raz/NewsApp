//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.instance.loadArticles()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newsDetailController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailScreen")
        self.navigationController?.pushViewController(newsDetailController, animated: true)
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
            as? NewsTableViewCell else {
                fatalError("Can't find cell")
        }
        return cell
    }
    
    
    
}
