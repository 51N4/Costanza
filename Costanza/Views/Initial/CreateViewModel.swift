//
//  CreateViewModel.swift
//  Costanza
//
//  Created by m4m4 on 20.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import Foundation

class CreateViewModel: ViewModel, ObservableObject {
    
    var temple: Temple
    
    init(temple:Temple) {
        self.temple = temple
    }
    
    func save() {
        print("SAVE")
    }
}
