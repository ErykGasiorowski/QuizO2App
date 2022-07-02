//
//  QuizListTableViewCell.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import UIKit
import Kingfisher
import SnapKit
import RxCocoa
import RxSwift

class QuizListTableViewCell: UITableViewCell {
    
    let button = UIButton()
    var disposeBag = DisposeBag()
    
    private let quizCoverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let quizNameLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 12, weight: .bold)
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
    
    override func prepareForReuse() {
        quizNameLabel.text = nil
        disposeBag = DisposeBag()
    }
    
    func configure(model: Quiz) {
        quizNameLabel.text = model.title
        // obrazki z api nie działają - wrzucono systemowy
        //quizCoverImage.kf.setImage(with: URL(string: model.mainPhoto.url ?? ""))
        //print(model.mainPhoto.url)
    }
    
    func setupView() {
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quizCoverImage)
        contentView.addSubview(quizNameLabel)
        contentView.addSubview(button)
        
        quizCoverImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
        
        quizNameLabel.snp.makeConstraints{
            $0.top.equalTo(quizCoverImage.snp.top).offset(50)
            $0.leading.equalTo(quizCoverImage.snp.leading).offset(50)
            $0.trailing.equalTo(quizCoverImage.snp.trailing).offset(-50)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
    }
}

