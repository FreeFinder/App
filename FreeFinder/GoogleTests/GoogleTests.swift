//
//  GoogleTests.swift
//  GoogleTests
//
//  Created by William Zeng on 10/31/22.
//

import XCTest

final class GoogleTests: XCTestCase {
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

    func testCreateUser() throws{
        //will create two users, one with valid email one without.
        //Note that a user has two fields: ID and email.

        //valid user will exist in the databse
        let goodUser = create_user("cbgravitt@uchicago.edu")
        ref.child("users/id/\(goodUser.id)").getData(completion: {error, snapshot in guard error == nil else {
            print(error!.localizedDescription)
            return;
        }
            //check that we found the proper ID, meaning it was stored
            let id = snapshot.value as? String ?? "Unknown";
            XCTAssertEqual(id, goodUser.id, "Wrong ID found");
        })

        //A user with an invalid email should have the initializer return nil
        let badUser = create_user("cbgravitt@gmail.com")
        XCTAssertNil(badUser, "User erroneously created");
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
