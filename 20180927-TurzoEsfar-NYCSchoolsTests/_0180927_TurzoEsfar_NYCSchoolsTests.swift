//
//  _0180927_TurzoEsfar_NYCSchoolsTests.swift
//  20180927-TurzoEsfar-NYCSchoolsTests
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import XCTest
@testable import _0180927_TurzoEsfar_NYCSchools

class _0180927_TurzoEsfar_NYCSchoolsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    //
    func testLoadData() {
        
        let engine = NetworkEngineMock()
        let loader = DataLoader(engine: engine)
        
        //var result: Result?
        let url = URL(string: "https://data.cityofnewyork.us/resource/97mf-9njv.json")!
        //loader.load(from: url) { result = $0 }
        loader.loadNYCSchoolData(from: url) { (result, error) in
            print(result)
        }
        XCTAssertEqual(engine.requestedURL, url)
    }
    
    func testSATFetchMethod() {
        
        let expect = expectation(description: "test SAT fetching method")
        let engine = NetworkEngineMock()
        let loader = DataLoader(engine: engine)
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/97mf-9njv.json") else {
            
            XCTFail()
            return
        }
        loader.loadNYCSATData(from: url) { (obj, error) in
            
            XCTAssertNil(error, "Unexpected error occured: \(String(describing: error?.localizedDescription))")
            XCTAssertTrue(obj.count > 0)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test time out: \(String(describing: error?.localizedDescription))")
        }
    }
}
