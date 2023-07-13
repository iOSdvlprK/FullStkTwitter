//
//  Extensions.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/10.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
