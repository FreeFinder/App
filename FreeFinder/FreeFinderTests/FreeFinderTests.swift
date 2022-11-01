//
//  FreeFinderTests.swift
//  FreeFinderTests
//
//  Created by Jordan Labuda on 10/31/22.
//

import XCTest

class FreeFinderTests: XCTestCase {
    var ref: DatabaseReference!
    ref = FIRDatabase.database().reference().child("items").child("id")
    
    
    override func setUpWithError() throws {
        var item1
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
        // for both empty DB and not empty
        // refresh is making all the annotations and putting them on map then for the list view it'll be for each annotation, make the UI list object
        
        // empty
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertNil(data)
            }
        }){ (error) in print(error.localizedDescription)}
        
        // add items somehow
        var annots //this is the list of annotations Charlie and William to make sure we can get this/fix syntax :))
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(annots.count, data.count)
            }
        }){ (error) in print(error.localizedDescription)}
    }
    
    func test_comment() throws{
        // Boolean comment(String c) is our function def
        // no need to check item exists as comment is an item method, and by construction
        
        //get initial state of
        ref.child(item1.id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                let firstComments = data["comments"]
            }
        }){ (error) in print(error.localizedDescription)}
        
        // fail on empty comment with no previous comments
        XCTAssertFalse(item1.comment(""))
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // pass on good comment w/ no prior comments
        XCTAssertTrue(item1.comment("Hi"))
        firstComments.append("Hi")
        ref.child(item1.id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // pass on good comment w/ prior comments
        XCTAssertTrue(item1.comment("Hi2"))
        firstComments.append("Hi2")
        ref.child(item1.id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
        
        // fail on empty comment with prior comments
        XCTAssertFalse(item1.comment(""))
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any]{
                XCTAssertEqual(firstComments, data["comments"])
            }
        }){ (error) in print(error.localizedDescription)}
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
