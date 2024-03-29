//
//  AccountSummaryViewControllerTest.swift
//  BankUnitTests
//
//  Created by Sunggon Park on 2024/03/29.
//

import XCTest

@testable import Bank

final class AccountSummaryViewControllerTest: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockProfileManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = AccountSummaryViewController()
        mockProfileManager = MockProfileManager()
        vc.profileManager = mockProfileManager
        vc.loadViewIfNeeded()   // This will trigger a call to viewDidLoad
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateTitleAndMessageForServerError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let (title, message) = vc.createTitleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", message)
    }
    
    func testCreateTitleAndMessageForDecodingError() throws {
        let (title, message) = vc.createTitleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", title)
        XCTAssertEqual("We could not process your request. Please try again.", message)
    }
    
    func testAlertForServerError() throws {
        mockProfileManager.error = NetworkError.serverError
        vc.doFetchProfileForTesting(group: DispatchGroup(), userId: "1")
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockProfileManager.error = NetworkError.decodingError
        vc.doFetchProfileForTesting(group: DispatchGroup(), userId: "1")
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
