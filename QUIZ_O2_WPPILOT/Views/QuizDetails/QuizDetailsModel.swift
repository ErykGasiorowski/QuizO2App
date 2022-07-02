//
//  QuizDetailsModel.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 09/04/2022.
//

import Foundation

struct QuizDetails: Codable {
    var title: String?
    var mainPhoto: QuizDetailsPhoto?
    var questions: [QuizQuestions]
    var canonical: String? 
    var rates: [Rate]?
    var buttonStart: String?
    let productUrl: String?
}

struct QuizDetailsPhoto: Codable {
    var url: String?
}

struct QuizQuestions: Codable {
    var order: Int
    var answers: [AnswerDetails]
    var image: QuizQuesionsImages?
    var text: String
}

struct AnswerDetails: Codable, Equatable {
    var isCorrect: Int?
    var order: Int?
    var text: String?
}

struct QuizQuesionsImages: Codable {
    var url: String?
}

struct Rate: Codable {
    var to: Int?
    var content: String?
    var from: Int?
}
