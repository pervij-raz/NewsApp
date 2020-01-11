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
    
    static let instance = PersistanceManager()
    
    private init(){
    }
    
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
    
    func saveContext () {
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
            let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context) as? Article
            article?.title = $0["title"] as? String
            article?.articleDescription = $0["description"] as? String
            article?.imageURl = $0["urlToImage"] as? String
            article?.articleURL = $0["url"] as? String
            let dateString = $0["publishedAt"] as? String
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from:dateString!)!
            article?.date = date
        }
        saveContext()
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
