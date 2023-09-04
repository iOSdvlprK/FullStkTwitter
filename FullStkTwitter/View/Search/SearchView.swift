//
//  SearchView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/08.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    @State private var isEditing = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var users: [User] {
        return text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(destination: UserProfile(user: user)) {
                        SearchUserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
