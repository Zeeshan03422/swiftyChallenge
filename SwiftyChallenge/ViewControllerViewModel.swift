//
//  ViewControllerViewModel.swift
//  SwiftyChallenge
//
//  Created by Syed Zeeshan Rizvi on 6/6/22.
//  Copyright © 2022 Monish Syed . All rights reserved.
//

import Foundation

protocol ViewControllerViewModelDelgate: AnyObject {
    func updateUI(question: Question)
    func show(error: String)
}

class ViewControllerViewModel: ViewControllerDelegate {
    
    var networkService: Service!
    weak var delegate: ViewControllerViewModelDelgate?
    var question: Question?
    
    init(networkService: Service, delegate: ViewControllerViewModelDelgate) {
        self.networkService = networkService
        self.delegate = delegate
    }
    
    func getQuestion() {
        
        let request = UrlRequest()
        networkService.get(request: request) { response in
            switch response {
            case .success(let success):
                do {
                    guard let object = try JSONSerialization.jsonObject(with: success) as? [String: Any] else {
                    return
                  }
                    let model = (object["questions"] as? [[String:Any]])
                    let data = model![0]
                    var answers: [Answer] = []
                    let answerArray = data["answers"] as! [[String:Any]]
                    for answer in answerArray {
                        answers.append(Answer(title: answer["title"] as! String, correct: answer["correct"] as! Bool))
                    }
                    let question = Question(query: data["query"] as! String, answers: answers)
                    self.question = question
                    self.delegate?.updateUI(question: question)
                } catch let error {
                    self.delegate?.show(error: error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.show(error: error.localizedDescription)
            }
        }
    }
    
    func isAnswerCorrect(index: Int) -> Bool {
        return (question?.answers[index].correct) ?? false
    }
}
