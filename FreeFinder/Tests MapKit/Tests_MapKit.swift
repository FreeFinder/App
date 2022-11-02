//
//  MapKitTests.swift
//  MapKitTests
//
//  Created by Charlie Gravitt on 10/31/22.
//

import XCTest

final class MapKitTests: XCTestCase {
    var ref: DatabaseReference!
    ref = FIRDatabase.database().reference().child("items").child("id")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testItemToAnnot() throws{
        //Transforms an Item into a GEOJson then into an annotation that can be placed on the map
        var item_valid_id = user.create_item(
            title: "test_title",
            subtitle: "test sub",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
            coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        )
        let pulled_annot = ItemToAnnot(item_valid_id)
        XCTAssertEqual(pulled_annot.title, "test_title", "Wrong title")
        XCTAssertEqual(pulled_annot.subtitle, "test sub", "Wrong subtitle")

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
