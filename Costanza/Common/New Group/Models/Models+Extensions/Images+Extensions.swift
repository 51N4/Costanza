//
//  Images.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import CoreData

extension Images: Identifiable {}

extension Images: DataModel {
    public static func request(_ id: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        if id != "" {
            fetchRequest.predicate = NSPredicate(format: "templeID == %@", id as CVarArg)
        }
        
        return fetchRequest
    }
}
