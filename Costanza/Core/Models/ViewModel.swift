//
//  ViewModel.swift
//  Costanza
//
//  Created by m4m4 on 20.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

public protocol ViewModel {}

public protocol StorableViewModel: ViewModel {
    associatedtype T : NSManagedObject
    var context: NSManagedObjectContext { get }
    var current: T? { get }
    func create()
    func delete(offsets:IndexSet,
                items: FetchedResults<T>)
    func save()
}
