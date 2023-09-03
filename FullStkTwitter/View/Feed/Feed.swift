//
//  Feed.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/08.
//

import SwiftUI

struct Feed: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    let user: User
    
    var body: some View {
        RefreshableScrollView(content:
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(spacing: 18) {
                    ForEach(viewModel.tweets) { tweet in
                        TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
                        Divider()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .zIndex(0) // in preparation for the hamburger menu
            })
        ) { control in
            self.viewModel.fetchTweets()
            control.endRefreshing()
        }
    }
}

//struct Feed_Previews: PreviewProvider {
//    static var previews: some View {
//        Feed()
//    }
//}
