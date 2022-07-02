//
//  ViewController.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class QuizListViewController: UIViewController {
    
    var viewModel: QuizListViewModel!
    
    let disposeBag = DisposeBag()
    let quizzesTableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindToViewModel()
        viewModel.fetchCharacters()
    }
    
    private func bindToViewModel() {
            viewModel.quizzes
                .subscribe(onNext: { drinks in
                    self.quizzesTableView.reloadData()
                }).disposed(by: disposeBag)
        }
    
    func setupLayout() {
        quizzesTableView.register(QuizListTableViewCell.self, forCellReuseIdentifier: String(describing: QuizListTableViewCell.self))
        quizzesTableView.translatesAutoresizingMaskIntoConstraints = false
        quizzesTableView.delegate = viewModel
        quizzesTableView.dataSource = viewModel
        
        view.addSubview(quizzesTableView)
        quizzesTableView.rowHeight = 200
        
        var frame = CGRect.zero
        
        quizzesTableView.frame.size.height = .leastNormalMagnitude
        quizzesTableView.tableHeaderView = UIView(frame: frame)
        quizzesTableView.tableFooterView = UIView(frame: frame)
        quizzesTableView.separatorStyle = .none
        
        quizzesTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    
    func goBackToHomeVC() {
        navigationController?.popViewController(animated: true)
    }
}
