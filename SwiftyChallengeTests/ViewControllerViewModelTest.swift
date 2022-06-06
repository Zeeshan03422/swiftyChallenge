//
//  ViewControllerViewModelTest.swift
//  SwiftyChallengeTests
//
//  Created by Syed Zeeshan Rizvi on 6/6/22.
//  Copyright © 2022 Monish Syed . All rights reserved.
//

import XCTest

@testable import SwiftyChallenge

class ViewControllerViewModelTest: XCTestCase {

    var viewModel: ViewControllerViewModel!
    var mockDelegate: MockViewControllerModelDelegate!
    var mockServicee: MockNetworkService!

    
    override func setUp() async throws {
        mockDelegate = MockViewControllerModelDelegate()
        mockServicee = MockNetworkService()
        viewModel = ViewControllerViewModel(networkService: mockServicee, delegate: mockDelegate)
    }
   
    func testGetQuestionWhenSuccess() {
        viewModel.getQuestion()
        XCTAssertNotNil(mockDelegate.question)
        XCTAssertNotNil(viewModel.question)
        XCTAssertEqual(mockDelegate.question?.query, "We can return multiple values from a function using?")
        XCTAssertEqual(mockDelegate.question?.answers.count, 4)
        XCTAssertEqual(mockDelegate.question?.answers[0].title, "Tuple")
        XCTAssertTrue(mockDelegate.question!.answers[0].correct)
        XCTAssertEqual(mockDelegate.question?.answers[1].title, "Array")
        XCTAssertFalse(mockDelegate.question!.answers[1].correct)
        XCTAssertEqual(mockDelegate.question?.answers[2].title, "Both 1st & 2nd")
        XCTAssertFalse(mockDelegate.question!.answers[2].correct)
        XCTAssertEqual(mockDelegate.question?.answers[3].title, "None")
        XCTAssertFalse(mockDelegate.question!.answers[3].correct)
    }
    
    func testGetQuestionWhenInvalidJson() {
        mockServicee.resposeType = .invalidJson
        viewModel.getQuestion()
        XCTAssertNil(mockDelegate.question)
        XCTAssertNil(viewModel.question)
        XCTAssertEqual(mockDelegate.error, "Invalid Json")
    }
    
    func testGetQuestionWhenFailure() {
        mockServicee.resposeType = .failure
        viewModel.getQuestion()
        XCTAssertNil(mockDelegate.question)
        XCTAssertNil(viewModel.question)
        XCTAssertEqual(mockDelegate.error, "The operation couldn’t be completed. (Server Not Responding error 404.)")
    }
    
    func testIsAnswerCorrect() {
        viewModel.getQuestion()
        XCTAssertTrue(viewModel.isAnswerCorrect(index: 0))
        XCTAssertFalse(viewModel.isAnswerCorrect(index: 1))
        XCTAssertFalse(viewModel.isAnswerCorrect(index: 2))
        XCTAssertFalse(viewModel.isAnswerCorrect(index: 3))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockDelegate = nil
        mockServicee = nil
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
