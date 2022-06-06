//
//  ViewController.swift
//  SwiftyChallenge
//
//  Created by Monish Syed  on 10/08/2020.
//  Copyright © 2020 Monish Syed . All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func getQuestion()
    func isAnswerCorrect(index: Int) -> Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var questionBackground: UIView!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var choiseOne: UILabel!
    @IBOutlet weak var choiseTwo: UILabel!
    @IBOutlet weak var choiseThree: UILabel!
    @IBOutlet weak var choiseFour: UILabel!

    @IBOutlet var buttonChoises: [UIButton]!
    
    var viewModel: ViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            viewModel = ViewControllerViewModel(networkService: NetworkService(), delegate: self)
        }
        submit.layer.cornerRadius = 5
        questionBackground.layer.cornerRadius = 10
        questionBackground.layer.masksToBounds = true
        question.text = "We can return multiple values from a function using?"
        
        viewModel.getQuestion()
    }
    
    @IBAction func buttonChoisesTappedHandler(_ sender: UIButton) {
        for button in buttonChoises {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func buttonSubmitTappedHandler(_ sender: UIButton) {
        for button in buttonChoises.enumerated() {
            if button.element.isSelected {
               showMessage(isAnswerCorrect: viewModel.isAnswerCorrect(index: button.offset))
            }
        }
    }
    
    func showMessage(isAnswerCorrect: Bool) {
        if isAnswerCorrect {
            show(error: "Your Answer Is Correct")
        } else {
            show(error: "Your Answer Is Wrong")
        }
        
    }
    
}


extension ViewController: ViewControllerViewModelDelgate {
    
    func updateUI(question: Question) {
        DispatchQueue.main.async {
            self.question.text = question.query
            self.choiseOne.text = question.answers[0].title
            self.choiseTwo.text = question.answers[1].title
            self.choiseThree.text = question.answers[2].title
            self.choiseFour.text = question.answers[3].title
        }
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Message", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
