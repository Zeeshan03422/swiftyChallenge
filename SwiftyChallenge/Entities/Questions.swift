//
//  Questions.swift
//  SwiftyChallenge
//
//  Created by Monish Syed  on 11/08/2020.
//  Copyright © 2020 Monish Syed . All rights reserved.
//

import Foundation

struct Question {
   
    let query: String // The prompt/title/question we want to ask
    let answers: [Answer] // List of answers (always 4)
}

struct Answer {
    let title: String // The prompt/title/answer choice to the question
    let correct: Bool // Is this the correct answer or not
}
