//
//  AccountSummaryViewController+Networking.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/28.
//

import Foundation
import UIKit

extension AccountSummaryViewController {
    func fetchDataAndLoadView() {
        let userId = String(Int.random(in: 1..<4))
        
        let group = DispatchGroup()
        
        doFetchProfile(group: group, userId: userId)
        doFetchAccounts(group: group, userId: userId)
       
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func doFetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
        profileManager.fetchProfile(forUserId: userId, completion: { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            
            group.leave()
        })
    }
    
    private func doFetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            group.leave()
        }
    }
    
    private func reloadView() {
        guard let profile = self.profile else { return }
        self.configureHeaderView(with: profile)
        self.configureTableCells(with: self.accounts)
        self.tableView.reloadData()
        self.isLoaded = true
    }
    
    private func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
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
   
    private func configureHeaderView(with profile: Profile) {
        let model = AccountSummaryHeaderModel(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        
        headerView.configure(model: model)
    }
    
    func configureTableCells(with accounts: [Account]) {
        accountModels = accounts.map {
            AccountModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        
        present(errorAlert, animated: true)
    }
     
    private func displayError(_ error: NetworkError) {
        let (title, message) = createTitleAndMessage(for: error)
        
        showErrorAlert(title: title, message: message)
    }
    
    private func createTitleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        }
        
        return (title, message)
    }
}

// MARK: Unit testing
extension AccountSummaryViewController {
    func createTitleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        return createTitleAndMessage(for: error)
    }
    
    func doFetchProfileForTesting(group: DispatchGroup, userId: String) {
        return doFetchProfile(group: group, userId: userId)
    }
}
