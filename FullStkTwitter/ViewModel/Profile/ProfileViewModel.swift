//
//  ProfileViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
