//
//  AccountSummaryViewController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    var accounts = [Account]()
    var accountModels = [AccountModel]()
    var profile: Profile?
    
    let tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
               
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupRefreshControl()
        setupTableHeaderView()
        fetchDataAndLoadView()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutButtonItem
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AccountSummaryCell", bundle: nil), forCellReuseIdentifier: AccountSummaryCell.identifier)
        
        tableView.rowHeight = AccountSummaryCell.height
        tableView.backgroundColor = CustomColors.appColor
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = CustomColors.appColor
        tableView.refreshControl?.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = view.frame.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableView
extension AccountSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as? AccountSummaryCell, !accounts.isEmpty else { return UITableViewCell() }
        cell.configure(with: accountModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Actions
extension AccountSummaryViewController {
    @objc private func logoutTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc private func refreshContent() {
        fetchDataAndLoadView()
        tableView.refreshControl?.endRefreshing()
    }
}
