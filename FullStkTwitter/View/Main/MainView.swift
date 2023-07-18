//
//  MainView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/11.
//

import SwiftUI

struct MainView: View {
    @State private var width = UIScreen.main.bounds.width - 90
    @State private var x = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    VStack {
                        TopBar(x: $x)
                        Home()
                    }
                    .offset(x: x + width)
                    
                    SlideMenu()
                        .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                        .offset(x: x)
                        .background(Color.black.opacity(x == 0 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                x = -width
                            }
                        }
                }
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {
                        if value.translation.width > 0 { // to right
                            if x < 0 {
                                x = -width + value.translation.width
                            }
                        } else {
                            if x != -width {
                                x = value.translation.width
                            }
                        }
                    }
                }).onEnded({ value in
                    withAnimation {
                        if -x < width / 2 {
                            x = 0
                        } else {
                            x = -width
                        }
                    }
                }))
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
