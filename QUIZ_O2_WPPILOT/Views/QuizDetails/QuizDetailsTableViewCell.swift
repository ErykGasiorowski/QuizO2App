//
//  QuizDetailsTableViewCell.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 10/04/2022.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

class QuizDetailsTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    private var viewModel: QuizDetailsViewModel!
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 9
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        
        return button
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupView()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(model: AnswerDetails) {
        answerLabel.text = model.text
    }
    
    override func prepareForReuse() {
        answerLabel.text = nil
        disposeBag = DisposeBag()
    }
    
    func setupView() {
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        contentView.addSubview(answerLabel)
        
        button.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
            $0.width.equalTo(50)
            $0.leading.equalTo(contentView.snp.leading)
        }
        
        answerLabel.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(button.snp.trailing).offset(10)
            $0.centerY.equalTo(button.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
    }
}
