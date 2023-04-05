//
//  ResponseModel.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 05/04/2023.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    let data: T
}
