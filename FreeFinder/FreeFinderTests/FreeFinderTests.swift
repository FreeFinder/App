//
//  FreeFinderTests.swift
//  FreeFinderTests
//
//  Created by Jordan Labuda on 10/31/22.
//
// trying for my life out here

import XCTest
import Firebase

class FreeFinderTests: XCTestCase {
    var ref: DatabaseReference!
    ref = Database.database(url: "https://freefinder-12f0c-default-rtdb.firebaseio.com/").reference().child("items")
    
    
    override func setUpWithError() throws {
        var test_user = User("user1id", "jlabuda@uchicago.edu") //need user instance to test respective functions
        var item1 = "itemid1" //will be id of test data already in DB
        var item2 = "testitemid2" // id of item not in DB
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
    
    func test_refresh() throws{

    }
    
    func test_comment() throws{        
        //get initial state of db
        ref.child(item1).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                let firstComments = data["comments"]
            }
        }){ (error) in print(error.localizedDescription)}
        
        // false: empty comment with no previous comments
        XCTAssertFalse(test_user.comment(item1,""))
        ref.child(item1).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // true: good comment w/ no prior comments
        XCTAssertTrue(test_user.comment(item1,"Hi"))
        firstComments.append("Hi")
        ref.child(item1).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // true: good comment w/ prior comments
        XCTAssertTrue(test_user.comment(item1,"Hi2"))
        firstComments.append("Hi2")
        ref.child(item1).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // false: empty comment with prior comments
        XCTAssertFalse(test_user.comment(item1, ""))
        ref.child(item1).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // false: comment on invalid item
        XCTAssertFalse(test_user.comment(item2, "hi"))
        
    }
    
    
    func test_create_item() throws{
        // will create a various amount of items, many of which are invalid
        // given that an invalid input will not write to the database, and will return nil, we just have to check that the returned value is nil
        
        var item_valid_id = user.create_item(
            title: "test_title",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
        )
        // now check that the id returned by the above user.create_item is in the database
        ref.child("items/\(item_valid_id)/id").getData(completion: {error, snapshot in guard error == nil else {
            print(error!.localizedDescription)
            return;
        }
            let id = snapshot.value as? String ?? "Unknown";
            XCTAssertEqual(id, item_valid_id);
        })
        
        
        // invalid title: title is too long
        var text_over_100_chars = "this_text_is_over_100_chars this_text_is_over_100_chars this_text_is_over_100_chars this_text_is_over_100_chars";
        var item_invalid_title = user.create_item(
            title: text_over_100_chars,
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_title);
        
        // invalid title: title is too short
        var item_invalid_title = user.create_item(
            title: "",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_title);
        
        // invalid photo
        var item_invalid_photo = user.create_item(
            title: "test",
            description: "desc_1",
            photo: 23,
            quanitity: 2,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_photo);
        
        // invalid quantity
        var item_invalid_quantity = user.create_item(
            title: "test_title",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 999,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_description);
        
        // invalid description: description is too short
        var item_invalid_desc_short = user.create_item(
            title: "test_title",
            description: "",
            photo: [[1,2], [1,2]],
            quanitity: 2,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_desc_short);
        
        var text_over_280_chars = "this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars this_text_is_over_280_chars ."
        // invalid description: description is too long
        var item_invalid_desc_long = user.create_item(
            title: "test_title",
            description: text_over_280_chars,
            photo: [[1,2], [1,2]],
            quanitity: 999,
        )
        // since item parameters are invalid and no item was created in the DB, the returned id will be nil
        XCTAssertNil(item_invalid_desc_long);
    }
    
    func test_delete_item() throws{
        // creates a valid item in the db
        // checks that the item is there
        // deletes the items, and then checks that the item is not there
        
        // creates a valid item and submits it to the db
        var item_valid_id = user.create_item(
            title: "test_title",
            description: "desc_1",
            photo: [[1,2], [1,2]],
            quanitity: 2,
        )
        // now check that the id returned by the above user.create_item is in the database
        ref.child("items/\(item_valid_id)/id").getData(completion: {error, snapshot in guard error == nil else {
            print(error!.localizedDescription)
            return;
        }
            let id = snapshot.value as? String ?? "Unknown";
            XCTAssertEqual(id, item_valid_id);
        })
        
        // deletes that item from the database
        user.delete_item(id: item_valid_id);
        
        
        // checks that the submitted item to the database is deleted
        ref.child("items/\(item_valid_id)/id").getData(completion: {error, snapshot in guard error == nil else {
            print(error!.localizedDescription)
            return;
        }
            let id = snapshot.value as? String ?? "Unknown";
            XCTAssertNil(id);
        })
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
