//
//  InitialView.swift
//  Costanza
//
//  Created by m4m4 on 20.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct TempleView: View {

    var model: TempleViewModel
    @Binding var state: ContentViewStep
    @State private var isCreating = false
    
    @FetchRequest(
        entity: Temple.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Temple.date, ascending: true)]
    ) var temples: FetchedResults<Temple>
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(temples){ temple in
                        NavigationLink(destination: CreateView(model: CreateViewModel(temple: temple), state: self.$state)) {
                            TempleRow(temple: temple)
                        }
                    }.onDelete(perform: delete)
                }.listStyle(GroupedListStyle())
            }
            if !isCreating {
                HStack{
                    Button(action: {
                        self.model.create()
                    }){
                        Text("Add Temple")
                    }
                }.frame(height: 42)
            }
        }
    }
    
    func delete(offsets:IndexSet) {
        model.delete(offsets: offsets, items: temples)
    }
}

struct TempleRow: View {
    var temple: Temple
    var body: some View {
        Text(temple.name ?? "SS")
            .background(Color(.red))
            .frame(height:100)
    }
}
