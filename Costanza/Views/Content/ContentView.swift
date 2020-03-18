//
//  ContentView.swift
//  Costanza
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    var temple: Temple
    var body: some View {
        Text(temple.name ?? "")
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Temple.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Temple.date, ascending: false)]
    ) var temples: FetchedResults<Temple>
    
    
    //var viewModel: ContentViewModel

    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.create()
                }){
                    Text("Add Temple")
                }
            }
            
            List {
                ForEach(temples){ temple in
                    TaskRow(temple: temple)
                }.onDelete(perform: delete)
                
            }
        }.navigationBarItems(trailing: EditButton())
    }
    
    func create() {
        let temple = Temple(context: context)
        
        temple.id = "Local Temple"//UUID().description
        temple.lat = 42.00
        temple.lon = 42.00
        temple.date = Date()
        temple.desc = "Core Data Temple Test"
        temple.imageURL = "local"
        temple.name = "T Test"
        
        try? context.save()
    }
   
    func delete(offsets:IndexSet ) {
        for index in offsets {
            let x = temples[index]
            context.delete(x)
        }
    }
}
