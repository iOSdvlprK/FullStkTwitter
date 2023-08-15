//
//  Tweet.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/15.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    let text: String
    let userId: String
    let username: String
    let user: String
}
