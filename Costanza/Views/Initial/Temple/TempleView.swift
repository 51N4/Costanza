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
    @State private var listID = 0
    
    @FetchRequest(
        entity: Temple.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Temple.date, ascending: true)]
    ) var temples: FetchedResults<Temple>
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(temples){ temple in
                        NavigationLink(destination: EmptyView()) {
                            TempleRow(temple: temple)
                        }
                    }.onDelete(perform: delete)
                        .onTapGesture {
                            self.listID += 1
                    }
                }.listStyle(GroupedListStyle())
                .id(listID)
            }
           
            HStack{
                Button(action: {
                    self.model.create()
                    self.isCreating.toggle()
                }){
                    Text("Add Temple")
                }.sheet(isPresented: $isCreating) {
                    CreateView(model:
                        CreateViewModel(temple: self.model.current),
                               isCreating: self.$isCreating,
                               refresh: self.$listID)
                   
                }
            }.frame(height: 42.0)
            .padding()
        }.onAppear(){
            print("SSS")
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
