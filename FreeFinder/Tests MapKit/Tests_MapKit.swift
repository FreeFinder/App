//
//  MapKitTests.swift
//  MapKitTests
//
//  Created by Charlie Gravitt on 10/31/22.
//

import XCTest
import UIKit
import MapKit

final class MapKitTests: XCTestCase {
    var ref: DatabaseReference!
    ref = FIRDatabase.database().reference().child("items").child("id")
    //declaring the ViewController under test as an implicitly unwrapped optional
    var viewControllerUnderTest : ViewController!

    override func setUpWithError() throws {
        // This is where setup code is
        super.setUp()
                //get the storyboard the ViewController under test is inside
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
                //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
                viewControllerUnderTest = storyboard.instantiateViewControllerWithIdentifier("MyViewController") as ViewController
                //load view hierarchy
                if(viewControllerUnderTest != nil) {
                    viewControllerUnderTest.loadView()
                    viewControllerUnderTest.viewDidLoad()
                }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func isMapLoaded() {
        // Checks if map is loaded in the test view
        XCTAssertNotNil(viewControllerUnderTest.mapView, "There is no Map View in unit test")
    }
    func isMapReloaded() {
        // Checks if map is loaded in the test view
        // Functino to reload the map
        reloadMap()
        
        // Asserts that the map is loaded and ready to go
        XCTAssertNotNil(viewControllerUnderTest.mapView, "There is no Map View in unit test")
        
        // Checks for the annotations on the map and if its greater than 0.
        let annotationsOnMap = self.viewControllerUnderTest.mapView.annotations
        XCTAssertGreaterThan(annotationsOnMap.count, 0)
    }
    
    func isMapViewProper() {
        // Checks if the view controller is aligned with apple mapkit protocol
        XCTAssert(viewControllerUnderTest.conformsToProtocol(MKMapViewDelegate), "ViewController violates MKMapViewDelegate protocol")
    }
    
    func isMapProper() {
        XCTAssertNotNil(self.viewControllerUnderTest.mapView.delegate, "MapView violates mapview delegate")
    }
    
    func testMapInitialization() {
        // Testing is map type is working
        // for this app we are most likely going to be using a roadmap since it will be campus specific
        XCTAssert(viewControllerUnderTest.mapView.mapType == MKMapType.roadmap);
    }
    
    func testControllerImplementsMKMapViewDelegateMethods() {
        // View Controller test if it is responsive to selecting annotations
        XCTAssert(viewControllerUnderTest.respondsToSelector(Selector("mapView:viewForAnnotation:")), "ViewController does not implement mapView:viewForAnnotation")
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
        
        // Checks if we can add the annotation
        let hasTestAnno = self.hasTargetAnnotation(pulled_annot)
        XCTAssertTrue(pulled_annot)
    }
    
    func testControllerAddsAnnotationsToMapView() {
        // Tests if any number of annotations is on the map
        let annotationsOnMap = self.viewControllerUnderTest.mapView.annotations
        XCTAssertGreaterThan(annotationsOnMap.count, 0)
    }
    
    func hasTargetAnnotation(sampleAnnotation: MKAnnotation.Type) -> Bool {
       let mapAnnotations = self.viewControllerUnderTest.mapView.annotations
       var hasTargetAnnotation = false
       for anno in mapAnnotations {
           if (anno.isKindOfClass(sampleAnnotation)) {
               hasTargetAnnotation = true
           }
       }
       return hasTargetAnnotation
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
