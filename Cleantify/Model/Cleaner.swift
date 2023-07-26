//
//  Cleaner.swift
//  Cleantify
//
//  Created by Muhammad Yusuf on 26/07/23.
//

import Foundation
import GameKit

struct Cleaner: Hashable, Comparable, Identifiable {
    static func < (lhs: Cleaner, rhs: Cleaner) -> Bool {
        return rhs.score > lhs.score
    }
    
    let id = UUID()
    let name: String
    let score: Int64
    let rank: Int
}
