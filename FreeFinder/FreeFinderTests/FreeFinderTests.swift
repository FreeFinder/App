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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
