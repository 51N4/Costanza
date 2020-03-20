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

enum ContentViewStep {
    case initial
    case create
    case name
    case picture
    case describe
}

class ContentViewModel: ViewModel, ObservableObject {
    @Published var currentStep: ContentViewStep = .initial
}
