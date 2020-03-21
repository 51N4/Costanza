//
//  InitialViewModel.swift
//  Costanza
//
//  Created by m4m4 on 20.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData


class TempleViewModel:StorableViewModel, ObservableObject {
    
    var context: NSManagedObjectContext

    private (set) var current: Temple?
    
    init( context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create() {
        current = Temple.create(context: context)
    }
    
    
    func addDescription(description:String, item: Temple) {
        item.setValue(description, forKey: "desc")
    }
    
    func addImageUrl(imageUrl:String, item:Temple) {
        item.setValue(imageUrl, forKey: "imageUrl")
    }
    
    func delete(offsets:IndexSet, items:FetchedResults<Temple>) {
        for index in offsets {
            let x = items[index]
            context.delete(x)
        }
        save()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
