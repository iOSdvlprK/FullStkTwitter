//
//  FeedViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/19.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.fetchData { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.tweets = tweets
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
