//
//  ViewController.swift
//  QuizO2_WPPILOT
//
//  Created by Eryk Gasiorowski on 04/04/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //let viewModel: QuizzesViewModel!
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(QuizListTableViewCell.self, forCellReuseIdentifier: "QuizListTableViewCell")
        tableView.backgroundColor = .white
        tableView.rowHeight = 200
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizListTableViewCell", for: indexPath) as? QuizListTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}

