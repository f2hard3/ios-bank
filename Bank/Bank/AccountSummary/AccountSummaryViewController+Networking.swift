//
//  AccountSummaryViewController+Networking.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/28.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

extension AccountSummaryViewController {
    func fetchDataAndLoadView() {
        let userId = String(Int.random(in: 1..<4))
        
        let group = DispatchGroup()
        
        group.enter()
        fetchProfile(forUserId: userId, completion: { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            group.leave()
        })
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    private func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
        guard let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    
                    completion(.success(profile))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    private func configureHeaderView(with profile: Profile) {
        let model = AccountSummaryHeaderModel(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        
        headerView.configure(model: model)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountModels = accounts.map {
            AccountModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
}
