//
//  CurrencyFormatterTests.swift
//  bankUnitTests
//
//  Created by Sunggon Park on 2024/03/26.
//

import XCTest
@testable import Bank

final class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formatter = CurrencyFormatter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBreakIntoDollarsAndCents() throws {
        let result = formatter.breakIntoDollarsAndCentsHelper(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormattedHelper(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormattedHelper(0)
        XCTAssertEqual(result, "$0.00")
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
