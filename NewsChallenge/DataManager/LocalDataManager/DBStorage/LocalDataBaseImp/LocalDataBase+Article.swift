//
//  CoreDataService+Article.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation
import CoreData

extension LocalDataBase: ArticleCoreData {    
    var entity: CoreDataEntity {
        return .CDArticle
    }
    
    func fetchArticlesData(with query: String) -> [CDArticle]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS %@\(query)")
    
        do {
            let results = try context.fetch(fetchRequest) as? [CDArticle]
            return results
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveArticles(_ articles: [Article]) {
        for article in articles {
            CDArticle(article: article, context: context)
        }
        persist()
    }
}
