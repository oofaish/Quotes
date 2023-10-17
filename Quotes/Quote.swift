//
//  Quote.swift
//  quotes
//
//  Created by Ali on 12/10/2023.
//

import Foundation

struct Quote: Hashable, Codable, Identifiable {
    var id: Int
    var quote: String
    var author: String
}
