//
//  FinishViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/8/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    var quizState = Quiz()
    
    @IBOutlet weak var praiseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func returnButton(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToStart", sender: quizState)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scoreLabel.text = "\(quizState.totalCorrect) of \(quizState.totalQuestions) correct"
        if quizState.totalQuestions == quizState.totalCorrect {
            praiseLabel.text = "Amazing!"
        } else if quizState.totalQuestions - 1 == quizState.totalCorrect {
            praiseLabel.text = "Almost!"
        } else {
            praiseLabel.text = "Try Harder!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
