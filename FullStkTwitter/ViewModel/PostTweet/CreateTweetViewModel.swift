//
//  CreateTweetViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/15.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    func uploadPost(text: String, image: UIImage?) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            print(result ?? "")
            
            if let image = image {
                if let id = result?["_id"] {
                    ImageUploader.uploadImage(paramName: "upload", filename: "image1", image: image, urlPath: "/uploadTweetImage/\(id)")
                }
            }
        }
    }
}
