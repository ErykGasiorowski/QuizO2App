//
//  QuizListTableViewCell.swift
//  QuizO2_WPPILOT
//
//  Created by Eryk Gasiorowski on 04/04/2022.
//

import UIKit
import Kingfisher

class QuizListTableViewCell: UITableViewCell {
    
    struct Model {
        let title: String?
        let url: String?
    }
    
    static let identifier = "QuizListTableViewCell"
    
    let button = UIButton()
    
    private let quizCoverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let quizNameLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupView()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        quizCoverImage.image = nil
        quizNameLabel.text = nil
    }
    
//    func configure(model: Quiz) {
//        quizNameLabel.text = model.title
//        quizCoverImage.kf.setImage(with: URL(string: model.mainPhoto.first?.url ?? ""))
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    }
}
