//
//  FullStkTwitterApp.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/08.
//

import SwiftUI

@main
struct FullStkTwitterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
