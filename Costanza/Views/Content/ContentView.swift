//
//  ContentView.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import SwiftUI


struct ContentView: View {
   
    @Environment(\.managedObjectContext) var context
    
    @State private var currentStep: ContentViewStep = .initial
    
    var body: some View {
        VStack {
            if currentStep == .initial {
                TempleView(model: TempleViewModel(context: context), state: $currentStep)
            } 
        }
    }
}
