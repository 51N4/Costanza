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
    
    @FetchRequest(
        entity: Temple.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Temple.date, ascending: true)]
    ) var temples: FetchedResults<Temple>
    
    let model: ContentViewModel = ContentViewModel()

    var body: some View {
        HStack {
            if model.currentStep == .initial {
                TempleView(model: TempleViewModel(temples: temples, context: context))
            }
        }
    }
}
