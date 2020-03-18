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
    func fetchTemples(_ id: String?) -> [Temple]
    func fetchImages(_ templeID: String?) -> [Images]
    func nukeTemple(_ id: String?)
    func nukeImage(_ templeID: String?)
    func nukeAll()
}


// MARK: - CostanzaStoraable
extension DataStorage: CostanzaStoraable {
    
    // MARK: - Core Data Interactions
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchTemples(_ id: String?) -> [Temple] {
        var temples: [Temple] = []
        do {
            let result = try context.fetch(Temple.request(id ?? ""))
            temples.append(contentsOf: result as! [Temple])
        } catch {
            print(error)
        }
        return temples
    }
    
    func fetchImages(_ templeID: String?) -> [Images] {
        var images: [Images] = []
        do {
            let result = try context.fetch(Images.request(templeID ?? ""))
            images.append(contentsOf: result as! [Images])
        } catch {
            print(error)
        }
        return images
    }
    
    func nukeTemple(_ id: String?) {
        deleteTemples(id ?? "")
    }
    
    func nukeImage(_ templeID: String?) {
        deleteImages(templeID ?? "")
    }
    
    func nukeAll() {
        deleteTemples("")
        deleteImages("")
    }
    
    // MARK: - Core Data Privates
    private func deleteTemples(_ id: String) {
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
    
    private func deleteImages(_ templeID: String) {
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
