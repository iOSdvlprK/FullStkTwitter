//
//  AuthViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/07.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    func login() {
        
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
