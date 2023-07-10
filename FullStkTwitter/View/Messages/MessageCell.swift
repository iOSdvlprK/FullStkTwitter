//
//  MessageCell.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/11.
//

import SwiftUI

struct MessageCell: View {
    @State private var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading) {
//            Divider()
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack {
                Image("tim-cook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Tim ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("@tim_cook")
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Text("7/11/23")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                    
                    Text("You: Hey! How is it going?")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .padding(.top, 2)
        }
        .frame(width: width, height: 84)
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell()
    }
}
