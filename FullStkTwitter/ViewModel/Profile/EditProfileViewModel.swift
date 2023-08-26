//
//  EditProfileViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/26.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    
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
    }
}
