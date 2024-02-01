//
//  HistoryViewController.swift
//  IntroChat
//
//  Created by Mina on 1/31/24.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    var introductions: [String] = [] {
        didSet {
            toggleSeperatorStyle()
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.historyTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableview()
        introductions = UserStore.shared.loadIntroduction()
        print(introductions)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTableview() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.rowHeight = UITableView.automaticDimension
    }
    
    func toggleSeperatorStyle() {
        if introductions.count == 1 {
            historyTableView.separatorStyle = .none
        } else {
            historyTableView.separatorStyle = .singleLine
        }
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            introductions.remove(at: indexPath.row)
            UserStore.shared.save(introductions: introductions)
            if introductions.isEmpty {
                introductions = UserStore.shared.loadIntroduction()
            }

        }
    }
}


extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return introductions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "introductionCell", for: indexPath) as? IntroductionTableViewCell else {
            return UITableViewCell()
        }
        cell.configureFor(introduction: introductions[indexPath.row])
        return cell
    }
}
