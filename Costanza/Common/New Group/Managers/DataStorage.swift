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
    func fetchTemples(id: String) -> [Temple]
    func fetchImages(id: String) -> [Images]
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
    
    // MARK: - Core Data Interactions
    
    func fetchTemples(id: String) -> [Temple] {
        var temples: [Temple] = []
        do {
            let result = try context.fetch(Temple.request(id))
            temples.append(contentsOf: result as! [Temple])
        } catch {
            print(error)
        }
        return temples
    }
    
    func fetchImages(id: String) -> [Images] {
        var images: [Images] = []
        do {
            let result = try context.fetch(Temple.request(id))
            images.append(contentsOf: result as! [Images])
        } catch {
            print(error)
        }
        return images
    }
    
    func nuke() {
        deleteAllTemples()
        deleteAllImages()
    }
    
    private func deleteAllTemples() {
        do {
            let results = try context.fetch(Temple.request(""))
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \("Temple") error :", error)
        }
    }
    
    private func deleteAllImages() {
        do {
            let results = try context.fetch(Images.request(""))
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \("Temple") error :", error)
        }
    }
}
