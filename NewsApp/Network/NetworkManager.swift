//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: Properties
    
    static let instance = NetworkManager()
    
    // MARK: Init
    
    private init(){
    }
    
    // MARK: Methods
    
    func loadArticles() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=gb&apiKey=04cbc856dcdb4bb283e1c204470cd0c3") else {return}
        
        AF.request(url).responseJSON { response in
            guard let error = response.error else {
                let data = response.value as? [String:Any]
                let articles = data?["articles"] as? [[String:Any]]
                PersistanceManager.instance.createData(from: articles)
                return
            }
            print(error.localizedDescription)
        }
    }
    
}
