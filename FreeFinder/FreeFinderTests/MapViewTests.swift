//
//  MapViewTests.swift
//  FreeFinderTests
//
//  Created by Ellen Chen on 10/31/22.
//

import XCTest

final class MapViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAnnotClick() throws {
        // create mock annotation object with ID 12345
        // check to ensure that annotClick should return '12345'
        // TODO: correct Annotation and annotClick parameters
        
        let mockAnnot = new Annot(12345);
        let mockId = annotClick();
        XCTAssertEqual(mockId, '12345');
        
        // what if database getter fails
        
        // valid payload
        // invalid payload
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
