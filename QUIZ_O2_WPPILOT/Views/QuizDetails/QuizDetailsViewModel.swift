//
//  QuizDetailsViewModel.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 09/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

class QuizDetailsViewModel: BaseViewModel {
    
    var onSuccess = PublishSubject<(QuizDetailsViewController.Model)>()
    var onError = PublishSubject<String>()
    var reloadData = PublishSubject<()>()
    var quizQuestions = BehaviorRelay<[AnswerDetails]>(value: [])
    var quizQuestionsCount = 0
    var score = 0
    
    var quizImage: String = ""
    private let quizID: Int
    private let service: QuizService
    var questions = [QuizQuestions]()
    var onEnd: (() -> Void)?
    
    init(quizID: Int,
         service: QuizService = CharacterServiceImpl()) {
        self.quizID = quizID
        self.service = service
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        service.getQuiz(id: quizID)
            .subscribe(onNext: { result in
                let model = QuizDetailsViewController.Model(quizTitle: result.title, order: result.questions.first?.order ?? 0, quizImage: result.mainPhoto?.url ?? "")
                
                self.quizQuestions.accept(result.questions.first?.answers ?? [])
                self.questions.append(contentsOf: result.questions)
                self.quizQuestionsCount = result.questions.count
                self.reloadData.onNext(())
                self.onSuccess.onNext(model)
            }, onError: { [weak self] error in
                self?.onError.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
   func getDataForTableView() {
        service.getQuiz(id: quizID)
           .subscribe(onNext: { [weak self] res in
                guard let self = self else { return }
                self.reloadData.onNext(())
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func finish() {
        self.onEnd?()
    }
    
    @objc private func didTapButton() {
        if questions.count > 1 {
            questions.remove(at: 0)
            getDataForTableView()
        } else if questions.count == 1 {
            questions.remove(at: 0)
            finish()
        }
    }
}

extension QuizDetailsViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.first?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: QuizDetailsTableViewCell.self), for: indexPath) as? QuizDetailsTableViewCell
        else {
            return UITableViewCell()
        }
        
        if questions.first!.answers.count <= indexPath.row {
            return cell
        }
        
        guard let item = questions.first?.answers[indexPath.row] else { return cell }
        
        cell.button.rx.tap.bind { [weak self] _ in
            if item.isCorrect == 1 {
                self?.score += 1
            }
            else {
                print("wrong")
            }
            self?.didTapButton()
        }.disposed(by: cell.disposeBag)
        
        cell.configure(model: item)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
