//
//  ConstazaStorable.swift
//  Costanza
//
//  Created by m4m4 on 18.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation

import CoreData

protocol CostanzaStoraable {
    var context: NSManagedObjectContext { get }
    func fetchTemples(id: String) -> [Temple]
    func fetchImages(templeID: String) -> [Images]
    func nukeTemple(id: String)
    func nukeImage(templeID: String)
    func nukeAll()
}


// MARK: - CostanzaStoraable
extension DataStorage: CostanzaStoraable {
    // MARK: - Core Data Interactions
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
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
    
    func fetchImages(templeID: String) -> [Images] {
        var images: [Images] = []
        do {
            let result = try context.fetch(Images.request(templeID))
            images.append(contentsOf: result as! [Images])
        } catch {
            print(error)
        }
        return images
    }
    
    func nukeTemple(id: String) {
        deleteTemples(id: "")
    }
    
    func nukeImage(templeID: String) {
        deleteImages(templeID: "")
    }
    
    func nukeAll() {
        deleteTemples(id: "")
        deleteImages(templeID: "")
    }
    
    // MARK: - Core Data Privates
    private func deleteTemples(id: String) {
        do {
            let results = try context.fetch(Temple.request(id))
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in Temple) error :", error)
        }
    }
    
    private func deleteImages(templeID: String) {
        do {
            let results = try context.fetch(Images.request(templeID))
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in Images error :", error)
        }
    }
    
}
