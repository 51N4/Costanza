
//
//  StorageTest.swift
//  CostanzaTests
//
//  Created by m4m4 on 16.03.20.
//  Copyright © 2020 mainvolume. All rights reserved.
//

import XCTest
@testable import Costanza


class StorageTest: XCTestCase {
    
    let storage = DataStorage()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storage.deleteAll()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() {
        print( storage.fetch() )
        storage.deleteAll()
        XCTAssertTrue(storage.fetch().count == 0)
    }
    
    func testStoreTemple() {
        
       
        
        
        let temple = Temple(context: storage.context)
        let image = Images(context: storage.context)
        
        image.id = UUID().description
        image.data = UIImage(named: "T")?.pngData()
        
        temple.id = UUID().description
        temple.lat = 42.00
        temple.lon = 42.00
        temple.date = Date()
        temple.desc = "Core Data Temple Test"
        temple.imageURL = "local"
        temple.templeImage = NSSet(array: [image])
        temple.name = "T Test"
        
        do {
            try storage.context.save()
        } catch {
            print(error)
            XCTFail()
        }
        
        let id = temple.id!
        let temples = storage.fetch(id: id)
        XCTAssert(temples.count > 0)
        XCTAssert(temples[0].templeImage!.count > 0)
    }
    
}
