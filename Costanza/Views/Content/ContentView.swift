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
        VStack {
            List {
                ForEach(temples){ temple in
                    TempleRow(temple: temple)
                }.onDelete(perform: delete)
            }.listStyle(GroupedListStyle())
            HStack{
                Button(action: {
                    self.model.create(context: self.context)
                }){
                    Text("Add Temple")
                }
            }.frame(height: 42)
        }
    }
    
    func delete(offsets:IndexSet) {
        model.delete(offsets: offsets,
                         items: temples,
                         context: context)
    }
}

struct TempleRow: View {
    var temple: Temple
    var body: some View {
        Text(temple.name ?? "")
            .frame(height:100)
    }
}
