//
//  PersistanceManager.swift
//  NewsApp
//
//  Created by Ольга Бычок on 11/01/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation
import CoreData

class PersistanceManager {
    
    // MARK: Properties
    
    static let instance = PersistanceManager()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Article")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Init
    
    private init(){
    }
    
    // MARK: Methods
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createData(from array: [[String:Any]]?) {
        guard let array = array else {return}
        array.forEach {
            let title = $0["title"] as? String
            _ = findArticle(with: title) ?? createArticle(from: $0)
            saveContext()
        }
        NotificationCenter.default.post(name: NSNotification.Name.init("Data is refreshed"), object: nil)
    }
    
    private func createArticle(from data: [String:Any]) -> Article? {
        let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context) as? Article
        article?.title = data["title"] as? String
        article?.articleDescription = data["description"] as? String
        article?.imageURl = data["urlToImage"] as? String
        article?.articleURL = data["url"] as? String
        let dateString = data["publishedAt"] as? String
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:dateString!)!
        article?.date = date
        return article
    }
    
    private func findArticle(with title: String?) -> Article? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let titlePredicate = NSPredicate(format: "title = %@", title ?? "")
        request.predicate = titlePredicate
        do {
            let articles = try context.fetch(request) as? [Article]
            return articles?.first
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func fetchData() -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            let items = try context.fetch(fetchRequest) as? [Article]
            return items ?? []
        } catch let error {
            print(error)
        }
        return []
    }
    
}
