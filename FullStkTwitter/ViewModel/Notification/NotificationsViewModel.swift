//
//  NotificationsViewModel.swift
//  FullStkTwitter
//
//  Created by joe on 2023/09/08.
//

import SwiftUI

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        fetchNotifications()
    }
    
    func fetchNotifications() {
        RequestServices.requestDomain = "http://localhost:3000/notifications/\(self.user.id)"
        
        RequestServices.fetchData { result in
            switch result {
            case .success(let data):
                guard let notifications = try? JSONDecoder().decode([Notification].self, from: data!) else { return }
                
                DispatchQueue.main.async {
                    self.notifications = notifications
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
