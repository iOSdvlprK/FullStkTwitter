//
//  TweetCellViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/20.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}
