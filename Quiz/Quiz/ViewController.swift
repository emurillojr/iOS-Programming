//
//  ViewController.swift
//  Quiz
//
//  Created by user135340 on 1/25/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet var questionLabel: UILabel!
    // replace your declaration of a single label with two labels
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
    "What is 7+7?",
    "What is the captal of Vermont?",
    "What is cognac made from?"
    ]
    
    let answers: [String] = [
    "14",
    "Montpelier",
    "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        //questionLabel.text = question
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        // call the animateLabelTransitions() method whenever the user taps the Next Question button.
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //questionLabel.text = questions[currentQuestionIndex]
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    // add a new method to handle the animations and declare a closure constant that takes in no arguments and does not return anything
    func animateLabelTransitions() {
        // Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        //let animationClosure = { () -> Void in
        // Add functionality to the closure that sets the alpha of the questionLabel to 1. Then, pass this closure as an argument to animate(withDuration:animations:)
        //    self.questionLabel.alpha = 1
        //}
        // Animate the alpha
        //UIView.animate(withDuration: 0.5, animations: animationClosure)
        //UIView.animate(withDuration: 0.5, animations: {
            //self.questionLabel.alpha = 1
        //    self.currentQuestionLabel.alpha = 0
        //    self.nextQuestionLabel.alpha = 1
        //})
        // and the center X constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveLinear],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        swap(&self.currentQuestionLabel,
                             &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint,
                             &self.nextQuestionLabelCenterXConstraint)
                        self.updateOffScreenLabel()
        })        
    }
    
    // override viewWillAppear(_:) to reset the questionLabel’s alpha to 0 each time the ViewController’s view comes onscreen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set the label's initial alpha
        //questionLabel.alpha = 0
        nextQuestionLabel.alpha = 0
    }
    
}

