//
//  QuizListViewModel.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

class QuizListViewModel: BaseViewModel {
    
    private let service: QuizService
    
    let quizzes = BehaviorRelay<[Quiz]>(value: [])
    
    init(service: QuizService) {
        self.service = service
    }
    
    func fetchCharacters() {
        service.getQuizzes()
            .subscribe(onNext: { res in
                self.quizzes.accept(res.items ?? [])
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func navigateToDetails(_ quizId: Int){
            AppNavigator.shared.navigate(to: CharacterRoutes.details(quizId), with: .push)
    }
}

extension QuizListViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: QuizListTableViewCell.self), for: indexPath) as? QuizListTableViewCell
        else {
            return UITableViewCell()
        }
        
        if quizzes.value.count <= indexPath.row {
            return cell
        }
        
        let item = quizzes.value[indexPath.row]
        
        cell.button.rx.tap.asObservable().bind { [weak self] _ in
            self?.navigateToDetails(item.id)
        }.disposed(by: cell.disposeBag)
        
        cell.configure(model: item)
        
        return cell
    }
}
