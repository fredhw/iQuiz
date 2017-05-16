//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/8/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var quizState = Quiz()
    
    @IBOutlet weak var quizTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var verdictLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIButton) {
        quizState.currQuizQuestionNumber = quizState.currQuizQuestionNumber + 1
        if quizState.currQuizQuestionNumber == quizState.totalQuestions + 1 {
            performSegue(withIdentifier: "FinishViewController", sender: quizState)
        } else {
            performSegue(withIdentifier: "NextQuestion", sender: quizState)
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToStart", sender: quizState)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quizTitle.title = quizState.currQuizName
        questionLabel.text = "\(quizState.currQuizQuestion)"
        if quizState.answerCorrect == false {
            verdictLabel.text = "Wrong! The answer was \(quizState.correctAnswer)"
        } else {
            verdictLabel.text = "Correct!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinishViewController {
            destination.quizState = quizState
        } else if let destination = segue.destination as? QuestionViewController {
            destination.quizState = quizState
        }
    }

}
