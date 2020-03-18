
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
       // storage.nuke()
    }
    
    override func tearDown() {
        storage.nukeAll()
    }
    
    
    func testStoreTemple() {
        
        let temple = Temple(context: storage.context)
        
        
        temple.id = "Local Temple"//UUID().description
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
        
        let temples = storage.fetchTemples(temple.id!)
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
        
        let imagesTrue = storage.fetchImages(image.templeID!)
        XCTAssert(imagesTrue.count > 0)
    }
    
}
