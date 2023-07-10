//
//  NotificationCell.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/10.
//

import SwiftUI

struct NotificationCell: View {
    @State private var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack(alignment: .top) {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.blue)
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Image("tim-cook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .cornerRadius(18)
                    
                    Text("Tim ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("followed you")
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.leading, 30)
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
