//
//  TweetCellViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/20.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    @Published var tweet: Tweet
    @Published var user: User?
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.fetchUser(userId: tweet.user)
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "http://localhost:3000/users/\(userId)"
        
        AuthServices.fetchUser(id: userId) { res in
            switch res {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data) else { return }
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func like() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.tweet.id)/like"
        
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("The tweet has been liked")
        }
    }
    
    func unlike() {
        RequestServices.requestDomain = "http://localhost:3000/tweets/\(self.tweet.id)/unlike"
        
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("The tweet has been unliked")
        }
    }
}
