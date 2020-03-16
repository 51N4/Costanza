
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
       
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storage.nuke()
    }
    
    
    func testStoreTemple() {
        
        let temple = Temple(context: storage.context)
        
        
        temple.id = UUID().description
        temple.lat = 42.00
        temple.lon = 42.00
        temple.date = Date()
        temple.desc = "Core Data Temple Test"
        temple.imageURL = "local"
        temple.name = "T Test"
        
        do {
            try storage.context.save()
        } catch {
            print(error)
            XCTFail()
        }
        
        let temples = storage.fetch(temples: temple.id!)
        XCTAssert(temples.count > 0)
    }
    
    func testStoreImage() {
        
        let image = Images(context: storage.context)
        image.id = UUID().description
        image.data = UIImage(named: "T")?.pngData()
        image.templeID = "Local Temple"
        
        do {
            try storage.context.save()
        } catch {
            print(error)
            XCTFail()
        }
        
        let images = storage.fetch(images: "Disco")
        XCTAssert(images.count == 0)
        
        let imagesTrue = storage.fetch(images: image.templeID!)
        XCTAssert(imagesTrue.count > 0)
    }
    
}
