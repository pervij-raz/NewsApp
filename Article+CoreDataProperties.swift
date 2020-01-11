//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Ольга Бычок on 11/01/2020.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var articleURL: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var imageURl: String?
    @NSManaged public var title: String?

}
