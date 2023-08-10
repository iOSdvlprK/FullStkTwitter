//
//  AuthViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/07.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    func login(email: String, password: String) {
        let defaults = UserDefaults.standard
        
        AuthServices.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else { return }
//                print(user)
                DispatchQueue.main.async {
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    defaults.set(user.user.id, forKey: "userid")
                    self?.isAuthenticated = true
                    self?.currentUser = user.user
                    print("logged in")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else { return }
                print(user)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        
    }
}
