//
//  Quiz.swift
//  iQuiz
//
//  Created by iGuest on 5/8/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit

class Quiz: NSObject {
    var currQuizName: String!
    var currQuizQuestion: String!
    var currQuizQuestionNumber: Int!
    var correctAnswer: String!
    var totalCorrect: Int!
    var totalQuestions: Int!
    var answerPressed: Bool = false
    var answerCorrect: Bool = false
    var questionList: [[String:String]]!
}
