//
//  CreateItemViewTests.swift
//  FreeFinderTests
//
//  Created by Ellen Chen on 10/31/22.
//

import XCTest

final class CreateItemViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateItemButton() throws {
        // TODO: implement createClick function
        // create function is tested for separately in FreeFinderTests
        let created = createClick("test_title", "desc", [[1,2], [1,2]], 2);
       
        // item should be created
        XCTAssertTrue(created)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
