//
//  CharacterRoutes.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import UIKit

enum CharacterRoutes: Route {
    case list
    case details(Int)

    var screen: UIViewController {
        switch self {
        case .list:
            return buildCharactersListViewController()
        case .details(let characterId):
            return buildCharactersDetailsViewController(characterId)
        }
    }
    
    private func buildCharactersListViewController() -> UIViewController {
        let controller = QuizListViewController()
        controller.viewModel = QuizListViewModel(service: CharacterServiceImpl.shared)
        return controller
    }
    
    private func buildCharactersDetailsViewController(_ quizID: Int) -> UIViewController {
        let viewModel = QuizDetailsViewModel(quizID: quizID, service: CharacterServiceImpl.shared)
        let controller = QuizDetailsViewController(viewModel: viewModel)
        return controller
    }
}
