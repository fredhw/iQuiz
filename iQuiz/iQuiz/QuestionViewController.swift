//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/8/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let prefs = UserDefaults.standard
    var questions = [[String:[String:String]]]()
    var quizState = Quiz()
    var selectedAnswer = ""
    var correct = ""
    var answers: [String] = []
    
    @IBOutlet weak var quizTitle: UINavigationItem!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func submitButton(_ sender: UIButton) {
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
        let chosen = self.prefs.object(forKey: "chosen") as? [String:Any]
        // Do any additional setup after loading the view.
        quizTitle.title = chosen?["title"] as? String
        let questionIndex = quizState.currQuizQuestionNumber  - 1
        let questionList = chosen?["questions"] as? [[String:Any]]
        quizState.totalQuestions = (questionList?.count)!
        let question = questionList?[questionIndex]
        let questionText = question?["text"] as? String
        answers = (question?["answers"] as? [String])! // picker data
        questionLabel.text = "Question \(quizState.currQuizQuestionNumber): \(questionText!)"
        let correctIndex = question?["answer"] as? String
        if correctIndex == "1" {
            correct = (answers[0])
        } else if correctIndex == "2" {
            correct = (answers[1])
        } else if correctIndex == "3" {
            correct = (answers[2])
        } else if correctIndex == "4" {
            correct = (answers[3])
        }
        submitButton.isEnabled = false
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        submitButton.isEnabled = true
        selectedAnswer = answers[row]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerViewController {
            quizState.currQuizQuestion = questionLabel.text!
            quizState.correctAnswer = correct
            destination.quizState = quizState
        }
    }

}
