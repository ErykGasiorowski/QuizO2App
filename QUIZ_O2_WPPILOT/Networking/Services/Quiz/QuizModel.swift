//
//  QuizModel.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation

struct QuizModel: Codable {
    var count: Int?
    var items: [Quiz]
}

struct Quiz: Codable {
    var questions: Int
    var title: String?
    var type: String?
    var id: Int
    var mainPhoto: QuizPhoto
}

struct QuizPhoto: Codable {
    var url: String?
}

