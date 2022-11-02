//
//  ItemTests.swift
//  FreeFinderTests
//
//  Created by Ellen Chen on 10/31/22.
//

import XCTest

final class ItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeleteItemButton(){
        var item = user.create_item(
            id: '12345',
            title: "test_title",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2
        )
        
        // TODO: implement deleteClick function
        // delete function is tested for separately in FreeFinderTests
        deleteClick('12345');
        
        // item should no longer exist
        XCTAssertNil(item);
        
        // deleting an a non-existent or already deleted item
        deleteClick('12345');
        XCTAssertNil(item);
    }
    
    func testCommentItemButton(){
        // create mock item and add comment
        var item = user.create_item(
            id: '12345',
            title: "test_title",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
            comments: []
        )
        
        // TODO: implement commentClick function
        // comment function is tested for separately in FreeFinderTests
        // returns true if comment is added to item
        val test1 = commentClick('12345', "Can I pick this up?");
        XCTAssertTrue(test1);
        
        // returns false if comment is not added to item
        // invalid item id
        val test2= commentClick('fail', "Cool product!");
        XCTAssertFalse(test2);
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
