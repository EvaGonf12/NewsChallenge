//
//  LocalDataBase.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation
import CoreData

protocol DbStorageService {
    var context: NSManagedObjectContext { get }
    func persist()
    func clear()
}

struct LocalDataBase: DbStorageService {
    
    var context: NSManagedObjectContext
    
    init(databaseName: String) {
        let container = NSPersistentContainer(name: databaseName)
        container.loadPersistentStores { ( _, error) in
            container.viewContext.mergePolicy = NSRollbackMergePolicy
            guard let error = error else { return }
            fatalError("CoreData Error ===>  \(error.localizedDescription)")
        }
        context = container.viewContext
    }
    
    func persist() {
        guard context.hasChanges else {
            print("CoreData ===> Nothinkg to change")
            return
        }
        
        do {
            try context.save()
        } catch {
            print("CoreData Save context Error ===>  \(error.localizedDescription)")
        }
    }
    
    func clear() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDArticle.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            persist()
        } catch let error as NSError {
            print(error)
        }
    }
    
}
