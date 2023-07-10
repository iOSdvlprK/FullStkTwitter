//
//  SearchUserCell.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/10.
//

import SwiftUI

struct SearchUserCell: View {
    var body: some View {
        HStack {
            Image("tim-cook")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Tim")
                    .fontWeight(.heavy)
                Text("@tim_cook")
            }
            
            Spacer(minLength: 0)
        }
    }
}

struct SearchUserCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserCell()
    }
}
