//
//  SearchBar.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/09.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search Twitter", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                }
        }
        .onTapGesture {
            isEditing = true
        }
    }
}

/*
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: $text, isEditing: $isEditing)
    }
}
*/
