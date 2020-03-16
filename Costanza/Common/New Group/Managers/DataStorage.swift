//
//  DataStorage.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStoraable {
    var context: NSManagedObjectContext { get }
}

public class DataStorage: CoreDataStoraable {
    // MARK: - Core Data stack
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Costanza")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //TODO clean up these to egenerics
    func fetch(id: String = "") -> [Temple] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Temple")
        if id != "" {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        }
        fetchRequest.fetchLimit = 1
        var temples: [Temple] = []
        do {
            let test = try context.fetch(fetchRequest)
            temples.append(contentsOf: test as! [Temple])
        } catch {
            print(error)
        }
        return temples
    }
    
    func deleteAll () {
        deleteAllTemples()
        deleteAllImages()
    }
    
    private func deleteAllTemples() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Temple")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \("Temple") error :", error)
        }
    }
    
    private func deleteAllImages() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \("Temple") error :", error)
        }
    }
}
