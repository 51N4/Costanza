//
//  Temple+Extensions.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import CoreData

extension Temple: Identifiable {}

extension Temple: DataModel {
    class func create(context: NSManagedObjectContext) -> Temple {
        let temple = Temple(context: context)
        temple.id = UUID().description
        temple.date = Date()
        return temple
    }
}
