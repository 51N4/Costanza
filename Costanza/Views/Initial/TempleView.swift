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

    let model: TempleViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(model.temples){ temple in
                    TempleRow(temple: temple)
                }.onDelete(perform: delete)
            }.listStyle(GroupedListStyle())
            HStack{
                Button(action: {
                    self.model.create()
                }){
                    Text("Add Temple")
                }
            }.frame(height: 42)
        }
    }
    
    func delete(offsets:IndexSet) {
        model.delete(offsets: offsets)
    }
}

struct TempleRow: View {
    var temple: Temple
    var body: some View {
        Text(temple.name ?? "")
            .frame(height:100)
    }
}
