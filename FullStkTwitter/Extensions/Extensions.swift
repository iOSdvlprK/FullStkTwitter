//
//  Extensions.swift
//  FullStkTwitter
//
//  Created by joe on 2023/07/10.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
