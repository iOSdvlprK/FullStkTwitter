//
//  ProfileViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.user.id)"
        
        RequestServices.fetchTweets { res in
            switch res {
            case .success(let data):
                guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data!) else { return }
                DispatchQueue.main.async {
                    self.tweets = tweets
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
