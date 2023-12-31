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
            
            Button(action: {
                isEditing = false
                text = ""
                UIApplication.shared.endEditing()
            }, label: {
                Text("Cancel")
                    .foregroundColor(.black)
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: 200) // value: TBD (https://stackoverflow.com/a/69443655)
            })
//            .padding(.trailing, 8)
//            .transition(.move(edge: .trailing))
//            .animation(.default)
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
