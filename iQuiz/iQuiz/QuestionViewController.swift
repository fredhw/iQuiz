//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/8/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions = [[String:[String:String]]]()
    var quizState = Quiz()
    var selectedAnswer = ""
    
    let math = [
        "question": "What is 1 + 1?",
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "correct": "2"
    ]
    
    let hero = [
        "question": "Who isn't a villain?",
        "one": "Joker",
        "two": "Dr. Octopus",
        "three": "Batman",
        "four": "Electro",
        "correct": "Batman"
    ]
    
    let science = [
        "question": "What does Na stand for?",
        "one": "Iron",
        "two": "Sodium",
        "three": "Magnesium",
        "four": "Barium",
        "correct": "Sodium"    ]
    
    func addSubjects() {
        questions.append(["Mathematics": math])
        questions.append(["Marvel Super Heroes": hero])
        questions.append(["Science": science])
    }
    
    @IBOutlet weak var quizTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var answerControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        submitButton.isEnabled = true
        selectedAnswer = answerControl.titleForSegment(at: answerControl.selectedSegmentIndex)!
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        let correct = quizState.questionList[quizState.currQuizQuestionNumber - 1]["correct"]
        if selectedAnswer == correct {
            quizState.answerCorrect = true
            quizState.totalCorrect = quizState.totalCorrect + 1
        }
        performSegue(withIdentifier: "AnswerViewController", sender: quizState)
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToStart", sender: quizState)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        quizTitle.title = quizState.currQuizName
        let questionIndex = quizState.currQuizQuestionNumber  - 1
        let question = quizState.questionList[questionIndex]["question"]
        questionLabel.text = "Question \(quizState.currQuizQuestionNumber!): \(question!)"
        answerControl.setTitle(quizState.questionList[questionIndex]["one"], forSegmentAt: 0)
        answerControl.setTitle(quizState.questionList[questionIndex]["two"], forSegmentAt: 1)
        answerControl.setTitle(quizState.questionList[questionIndex]["three"], forSegmentAt: 2)
        answerControl.setTitle(quizState.questionList[questionIndex]["four"], forSegmentAt: 3)
        submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerViewController {
            quizState.currQuizQuestion = quizState.questionList[quizState.currQuizQuestionNumber - 1]["question"]
            quizState.correctAnswer = quizState.questionList[quizState.currQuizQuestionNumber - 1]["correct"]
            destination.quizState = quizState
        }
    }

}
