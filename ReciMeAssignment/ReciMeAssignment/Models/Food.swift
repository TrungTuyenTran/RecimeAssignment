//
//  Food.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 05/04/2023.
//

import Foundation

struct Food: Codable, Hashable {
    let name: String
    let level: String
    let position: Int
    let imageUrl: String
}
