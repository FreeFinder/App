//
//  MapViewTests.swift
//  FreeFinderTests
//
//  Created by Ellen Chen on 10/31/22.
//

import XCTest

final class ListViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListClick() throws {
        // create mock list object item with ID 12345
        // check to ensure that listClick should return '12345'
        // TODO: correct ListItem and listClick parameters
        
        let mockListItem = new ListItem(12345);
        let mockId = listClick();
        XCTAssertEqual(mockId, '12345');
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
