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

protocol ViewModel {
    associatedtype T: CostanzaStoraable
    var storage: T { get }
    var id: Int { get set }
}

class ContentViewModel: ViewModel, ObservableObject {
    
    var storage: DataStorage
    @Published var id: Int = 0
    
    @FetchRequest(
        entity: Temple.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Temple.date, ascending: false)]
    ) var temples: FetchedResults<Temple>
  
    

    init(storage: DataStorage) {
        self.storage = storage
    }
    
}
