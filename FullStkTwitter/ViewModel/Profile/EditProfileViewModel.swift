//
//  EditProfileViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/26.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, bio: String?, website: String?, location: String?) {
        guard let userNewName = name else { return }
        guard let userNewBio = bio else { return }
        guard let userNewWebsite = website else { return }
        guard let userNewLocation = location else { return }
        
        self.user.name = userNewName
        self.user.bio = userNewBio
        self.user.website = userNewWebsite
        self.user.location = userNewLocation
//        self.uploadComplete.toggle()
    }
    
    func uploadUserData(name: String?, bio: String?, website: String?, location: String?) {
        let userId = user.id
        let urlPath = "/users/\(userId)"
        let url = URL(string: "http://localhost:3000\(urlPath)")!
        
        var requestBody: [String: String] = [:]
        
        if let name = name {
            requestBody["name"] = name
        }
        if let bio = bio {
            requestBody["bio"] = bio
        }
        if let website = website {
            requestBody["website"] = website
        }
        if let location = location {
            requestBody["location"] = location
        }
        
        AuthServices.makePatchRequestWithAuth(urlString: url, reqBody: requestBody) { res in
            
            DispatchQueue.main.async {
                self.save(name: name, bio: bio, website: website, location: location)
                self.uploadComplete = true
            }
        }
    }
}
