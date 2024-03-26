//
//  AccountSummaryViewController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    private var accounts = [AccountModel]()
    private let tableView = UITableView()
    lazy var logoutButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
               
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        fetchData()
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
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = view.frame.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
}

// MARK: - UITableView
extension AccountSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.identifier, for: indexPath) as? AccountSummaryCell, !accounts.isEmpty else { return UITableViewCell() }
        cell.configure(with: accounts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        accounts = fetchAccount()
        fetchProfile()
    }
    
    private func fetchAccount() -> [AccountModel] {
        let savings = AccountModel(accountType: .Banking,
                                   accountName: "Basic Savings",
                                   balance: 929466.23)
        let chequing = AccountModel(accountType: .Banking,
                                    accountName: "No-Fee All-In Chequing",
                                    balance: 17562.44)
        let visa = AccountModel(accountType: .CreditCard,
                                accountName: "Visa Avion Card",
                                balance: 412.83)
        let masterCard = AccountModel(accountType: .CreditCard,
                                      accountName: "Student Mastercard",
                                      balance: 50.83)
        let investment1 = AccountModel(accountType: .Investment,
                                       accountName: "Tax-Free Saver",
                                       balance: 2000.00)
        let investment2 = AccountModel(accountType: .Investment,
                                       accountName: "Growth Fund",
                                       balance: 15000.00)
        
        return [savings, chequing, visa, masterCard, investment1, investment2]
    }
    
    private func fetchProfile() {
        
    }
}

// MARK: - Actions
extension AccountSummaryViewController {
    @objc private func logoutTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
