//
//  ProfileTests.swift
//  BankUnitTests
//
//  Created by Sunggon Park on 2024/03/28.
//

import XCTest
@testable import Bank

final class ProfileTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanParse() throws {
        let json = """
            {
            "id": "1",
            "first_name": "Kevin",
            "last_name": "Flynn",
            }
            """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
    
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
