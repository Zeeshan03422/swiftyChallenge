//
//  MockViewControllerModelDelegate.swift
//  SwiftyChallengeTests
//
//  Created by Syed Zeeshan Rizvi on 6/6/22.
//  Copyright © 2022 Monish Syed . All rights reserved.
//

import Foundation
@testable import SwiftyChallenge

class MockViewControllerModelDelegate: ViewControllerViewModelDelgate {
    
    var question: Question?
    var error: String?

    func updateUI(question: Question) {
        self.question = question
    }
    
    func show(error: String) {
        self.error = error
    }
    
}
