//
//  ContentViewAssembler.swift
//  Costanza
//
//  Created by m4m4 on 18.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

public protocol ViewModel {
    associatedtype T : NSManagedObject
    func create( context: NSManagedObjectContext)
    func delete(offsets:IndexSet,
                items: FetchedResults<T>,
                context: NSManagedObjectContext)
}

class ContentViewModel: ViewModel, ObservableObject {
    
    
    func create( context: NSManagedObjectContext) {
        
        let temple = Temple(context: context)
        
        temple.id = UUID().description
        temple.lat = 42.00
        temple.lon = 42.00
        temple.date = Date()
        temple.desc = "Core Data Temple Test"
        temple.imageURL = "local"
        temple.name = "T Test - \(Date())"
        
        try? context.save()
    }
    
    func delete(offsets:IndexSet,
                items: FetchedResults<Temple>,
                context: NSManagedObjectContext) {
        
        for index in offsets {
            let x = items[index]
            context.delete(x)
        }
        
        try? context.save()
    }
}
