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
        checkIfUserIsCurrentUser()
        checkIfUserIsFollowed()
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
    
    func checkIfUserIsCurrentUser() {
        if (self.user._id == AuthViewModel.shared.currentUser?._id) {
            self.user.isCurrentUser = true
        }
    }
    
    func follow() {
        RequestServices.requestDomain = "http://localhost:3000/users/\(self.user.id)/follow"
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result as Any)
            print("Followed")
        }
        self.user.isFollowed = true
    }
    
    func unfollow() {
        RequestServices.requestDomain = "http://localhost:3000/users/\(self.user.id)/unfollow"
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result as Any)
            print("Unfollowed")
        }
        self.user.isFollowed = false
    }
    
    func checkIfUserIsFollowed() {
        if (self.user.followers.contains(AuthViewModel.shared.currentUser!._id)) {
            self.user.isFollowed = true
        }
        else {
            self.user.isFollowed = false
        }
    }
}
