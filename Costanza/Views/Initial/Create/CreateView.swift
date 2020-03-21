//
//  CreateView.swift
//  Costanza
//
//  Created by m4m4 on 20.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation
import SwiftUI

struct CreateView: View {
    
    @ObservedObject var model: CreateViewModel
    @Binding var isCreating: Bool
    @Binding var refresh: Int
    @State private var name:String = ""
    
    
    var body: some View {
        VStack{
            Text(model.temple == nil ? "Error creating Temple" : "No name")
            TextField("Temple Name", text: $name)
            if name.count > 0 {
                Button(action: {
                    self.model.addName(name: self.name)
                    self.isCreating.toggle()
                    self.refresh += 1
                }){
                    Text("Set Temple Name")
                }
            }
        }
    }
    
}
