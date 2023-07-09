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
    
    var body: some View {
        VStack {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            List(0..<9) { i in
                SearchCell(tag: "Hello", tweets: String(i))
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
