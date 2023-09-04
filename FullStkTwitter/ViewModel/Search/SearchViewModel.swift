//
//  SearchViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/09/04.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        AuthServices.requestDomain = "http://localhost:3000/users"
        
        AuthServices.fetchUser { result in
            switch result {
            case .success(let data):
                guard let users = try? JSONDecoder().decode([User].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
