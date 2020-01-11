//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articles = PersistanceManager.instance.fetchData().sorted{
        $0.date ?? Date() < $1.date ?? Date()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.instance.loadArticles()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNews),
                                               name: NSNotification.Name("Data is refreshed"), object: nil)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        NetworkManager.instance.loadArticles()
    }

    
    @objc private func refreshNews() {
        articles = PersistanceManager.instance.fetchData().sorted{
            $0.date ?? Date() < $1.date ?? Date()
        }
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let newsDetailController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailScreen") as? ViewController else {return nil}
        self.navigationController?.pushViewController(newsDetailController, animated: true)
        newsDetailController.setup(with: articles[indexPath.row])
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
            as? NewsTableViewCell else {
                fatalError("Can't find cell")
        }
        cell.setup(with: articles[indexPath.row])
        return cell
    }
    
    
    
    
}
