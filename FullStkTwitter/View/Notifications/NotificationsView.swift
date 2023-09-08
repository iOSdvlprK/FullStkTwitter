//
//  NotificationsView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/08.
//

import SwiftUI

struct NotificationsView: View {
    let user: User
    
    @ObservedObject var viewModel: NotificationsViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = NotificationsViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.notifications) { notification in
                    
                    NotificationCell(notification: notification)
                    
                }
            }
        }
    }
}

//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}
