//
//  QuizResource.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation
import Moya

enum QuizResource: TargetType {
    
    case getQuizzes
    case getQuiz(Int)
    
    var path: String {
        switch self {
        case .getQuizzes:
            return "quizzes/0/100"
            //"quizzes/0/100"
        case .getQuiz(let id):
            return "quiz/\(id)/0"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getQuizzes, .getQuiz:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return getHeaders()
    }
    
    var task: Task {
        switch self {
        case .getQuizzes:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
            
        case .getQuiz:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
}
