//
//  ContentView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/08.
//

import SwiftUI

// GeometryReader practice
struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("Hello World, how are you?")
                    .font(.largeTitle)
                    .frame(width: geometry.size.width / 2, height: (geometry.size.height / 4) * 3)
                    .background(Color.yellow)
                    .border(Color.black)
                
                Text("Goodbye World")
                    .font(.largeTitle)
                    .frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
                    .background(Color.green)
                    .border(Color.purple)
            }
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
