//
//  CreateTweetView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/09.
//

import SwiftUI

struct CreateTweet: View {
    @Binding var show: Bool
    @State var text = ""
    
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    if text != "" {
                        self.viewModel.uploadPost(text: text)
                    }
                    self.show.toggle()
                    
                }, label: {
                    Text("Tweet")
                        .padding()
                })
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            MultilineTextField(text: $text)
        }
        .padding()
    }
}

//struct CreateTweetView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTweet()
//    }
//}
