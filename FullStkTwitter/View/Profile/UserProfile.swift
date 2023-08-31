//
//  UserProfile.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/12.
//

import SwiftUI
import Kingfisher

struct UserProfile: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    var isCurrentUser: Bool {
        return viewModel.user.isCurrentUser ?? false
    }
    
    @State private var editProfileShow = false
    
    @State private var offset: CGFloat = 0
    @State private var titleOffset: CGFloat = 0
    @State private var tabBarOffset: CGFloat = 0
    @State private var currentTab = "Tweets"
    
    // for smooth slide animation
    @Namespace var animation
    
    // for dark mode adoption
    @Environment(\.colorScheme) var colorScheme
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
//        print("isCurrentUser: \(viewModel.user.isCurrentUser ?? false)")
    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy -> AnyView in
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return AnyView(
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: minY > 0 ? minY + 180 : 180, alignment: .center)
                                .cornerRadius(0)
                            
                            BlurView()
                                .opacity(blurViewOpacity())
                            
                            VStack(spacing: 5) {
                                Text(self.user.username)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("150 tweets")
                                    .foregroundColor(.white)
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                        }
                        .clipped()
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                
                VStack {
                    HStack {
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                            .placeholder({
                                Image("blankpp")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white.clipShape(Circle()))
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                        if (self.isCurrentUser) {
                            Button(action: {
                                self.editProfileShow.toggle()
                            }, label: {
                                Text("Edit Profile")
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Capsule()
                                        .stroke(Color.blue, lineWidth: 1.5))
                            })
                            .sheet(isPresented: $editProfileShow) {
                                
                            } content: {
                                EditProfileView(user: $viewModel.user)
                            }
                        }
                        else {
                            Button {
                                // Add the func to follow and unfollows
                                self.viewModel.follow()
                            } label: {
                                Text("Follow")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(
                                        ZStack {
                                            Capsule()
                                                .foregroundColor(.black)
                                        }
                                    )
                            }
                        }
                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(self.viewModel.user.username)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("@\(self.viewModel.user.username)")
                                .foregroundColor(.gray)
                            
                            Text(viewModel.user.bio ?? "CEO of Apple and serves on its board of directors and former vice president of Corporate Materials for Compaq")
                            
                            HStack(spacing: 8) {
                                if let userLocation = viewModel.user.location {
                                    if (userLocation != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "mappin.circle.fill")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            Text(userLocation)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                                
                                if let userWebsite = viewModel.user.website {
                                    if (userWebsite != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "link")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            Text(userWebsite)
                                                .foregroundColor(Color("twitter"))
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                            }
                            
                            HStack(spacing: 5) {
                                Text("780")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                
                                Text("Followers")
                                    .foregroundColor(.gray)
                                
                                Text("13")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 10)
                                
                                Text("Following")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.leading, 8)
                        .overlay(alignment: .top) {
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    self.titleOffset = minY
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 0, height: 0)
                        }
                        Spacer()
                    }
                    
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                TabButton(title: "Tweets", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Tweets & Likes", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        }
                        
                        Divider()
                    }
                    .padding(.top, 30)
                    .background(Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(alignment: .top) {
                        GeometryReader { proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.tabBarOffset = minY
                            }
                            
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                    }
                    .zIndex(1)
                    
                    VStack(spacing: 18) {
                        ForEach(viewModel.tweets) { tweet in
                            TweetCellView(viewModel: TweetCellViewModel(tweet: tweet))
                        }
                    }
                    .padding(.top)
                    .zIndex(0)
                }
                .padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset() -> CGFloat {
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }
}

//struct UserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfile()
//    }
//}
