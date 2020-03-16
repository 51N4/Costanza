//
//  DataModel.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//
import CoreData

public protocol DataModel {
    static var entityName:String { get }
    static func request(_ id: String) -> NSFetchRequest<NSFetchRequestResult>
}

public extension DataModel {
    static func request(_ id: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        if id != "" {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1
        }
        return fetchRequest
    }
    
    static var entityName: String {
        return String(describing: self)
    }
}

