//
//  QuizService.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation
import RxSwift
import Moya

protocol QuizService {
    func getQuizzes() -> Observable<QuizModel>
    func getQuiz(id: Int) -> Observable<QuizDetails>
}

class CharacterServiceImpl: BaseApiService<QuizResource>, QuizService {
    
    static var shared = CharacterServiceImpl()
    
    func getQuizzes() -> Observable<QuizModel> {
        return request(for: .getQuizzes)
            .map {(items: QuizModel, _ response: Response) in
                return items
        }
    }
    
    func getQuiz(id: Int) -> Observable<QuizDetails> {
        return request(for: .getQuiz(id))
            .map {(item: QuizDetails, _ response: Response) in
                return item
        }
    }
}
