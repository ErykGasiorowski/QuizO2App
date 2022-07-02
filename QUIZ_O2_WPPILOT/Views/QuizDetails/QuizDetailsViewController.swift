//
//  QuizDetailsViewController.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 09/04/2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class QuizDetailsViewController: UIViewController {
    
    struct Model {
        var quizTitle: String?
        var order: Int
        var quizImage: String?
    }
    
    var quizImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemMint
        image.layer.borderColor = UIColor.systemGray.cgColor
        
        return image
    }()
    
    let quizTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    let disposeBag = DisposeBag()
    private var viewModel: QuizDetailsViewModel
    
    var tableView: UITableView = UITableView()
    let homeVC = QuizListViewController()
    var questionsArray = [QuizQuestions]()
    
    init(viewModel: QuizDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupBehavior()
        viewModel.viewDidLoad()
        setupView()
        view.clipsToBounds = true
    }
    
    func setup(model: Model) {
        quizTitleLabel.text = model.quizTitle
        quizImage.kf.setImage(with: URL(string: model.quizImage ?? ""))
        setupQuestion()
    }
    
    func setupQuestion() {
        questionLabel.text = viewModel.questions.first?.text
    }
  
    func setupBehavior() {
        viewModel.onSuccess.bind {
            self.setup(model: $0)
        }.disposed(by: disposeBag)
        
        viewModel.onError.bind {
            print($0)
        }.disposed(by: disposeBag)
        
        viewModel.reloadData.bind { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.setupQuestion()
        }
        
        viewModel.onEnd = { [weak self] in
            let alert = UIAlertController(title: "Congratulations! You've finished the quiz.", message: "Your score: \(self!.viewModel.score) out of \(self!.viewModel.quizQuestionsCount)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Back to homepage", style: UIAlertAction.Style.default, handler: { _ in
                self?.navigationController?.popToRootViewController(animated: true)
            }))
            
            self!.present(alert, animated: true, completion: .none)
        }
        
    }

    func setupView() {
        tableView.register(QuizDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: QuizDetailsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(quizTitleLabel)
        view.addSubview(quizImage)
        view.addSubview(questionLabel)
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.rowHeight = 50
        
        var frame = CGRect.zero
        
        tableView.frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        tableView.separatorStyle = .none
        
        quizTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(80)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        quizImage.snp.makeConstraints {
            $0.top.equalTo(quizTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(quizImage.snp.width)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(quizImage.snp.bottom).offset(30)
            $0.leading.equalTo(quizImage.snp.leading)
            $0.trailing.equalTo(quizImage.snp.trailing)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(30)
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.trailing.equalTo(questionLabel.snp.trailing)
            $0.bottom.equalTo(view.safeAreaInsets).offset(-20)
        }
    }
}
