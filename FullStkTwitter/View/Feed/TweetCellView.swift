//
//  TweetCellView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/09.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    @ObservedObject var viewModel: TweetCellViewModel
    
    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10, content: {
                if let user = viewModel.user {
                    NavigationLink(destination: UserProfile(user: user)) {
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.tweet.userId)/avatar"))
                            .placeholder({
                                Image("blankpp")
                                    .resizable()
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                    }
                }
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("\(self.viewModel.tweet.username) ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("@\(self.viewModel.tweet.username)")
                        .foregroundColor(.gray)
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let imageId = viewModel.tweet.id {
                        if viewModel.tweet.image == "true" {
                            
                            GeometryReader { proxy in
                                KFImage(URL(string: "http://localhost:3000/tweets/\(imageId)/image"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 250)
                                    .cornerRadius(15)
                            }
                            .frame(height: 250)
                        }
                    }
                })
                
                Spacer()
            })
            
            // cell bottom
            HStack(spacing: 50, content: {
                Button(action: {
                    
                }, label: {
                    Image("Comments")
                        .resizable()
                        .frame(width: 16, height: 16)
                })
                .foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("Retweet")
                        .resizable()
                        .frame(width: 18, height: 14)
                })
                .foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("love")
                        .resizable()
                        .frame(width: 18, height: 15)
                })
                .foregroundColor(.gray)
                
                Button(action: {
                    
                }, label: {
                    Image("upload")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 15)
                })
                .foregroundColor(.gray)
            })
            .padding(.top, 4)
        }
    }
}

//struct TweetCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetCellView(tweet: sampleText)
//    }
//}

var sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
