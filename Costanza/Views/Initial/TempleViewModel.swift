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


class TempleViewModel:StorableViewModel {
    
    var temples: FetchedResults<Temple>
    var context: NSManagedObjectContext
    
    var currentTemple:Temple?
    
    init(temples:FetchedResults<Temple>, context: NSManagedObjectContext) {
        self.temples = temples
        self.context = context
    }
    
    func create() {
        let temple = Temple(context: context)
        temple.id = UUID().description
        temple.date = Date()
        currentTemple = temple
    }
    
    func addName(name:String) {
        currentTemple?.setValue(name, forKey: "name")
    }
    
    func addDescription(description:String) {
        currentTemple?.setValue(description, forKey: "desc")
    }
    
    func addImageUrl(imageUrl:String) {
        currentTemple?.setValue(imageUrl, forKey: "imageUrl")
    }
    
    func delete(offsets:IndexSet) {
        for index in offsets {
            let x = temples[index]
            context.delete(x)
        }
        save()
    }
    
    func save() {
        try? context.save()
    }

}
