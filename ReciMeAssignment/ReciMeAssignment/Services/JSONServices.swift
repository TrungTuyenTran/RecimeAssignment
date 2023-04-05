//
//  JSONServices.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 05/04/2023.
//

import Foundation
import Combine

protocol IJSONServices {
    func get<T: Codable>(_ type: T.Type, from fileName: String) -> AnyPublisher<T, Error>
}
//class JSONFileServices: NSObject {
//    func get<T: Codable>(_ type: T.Type, from fileName: String) -> AnyPublisher<T, Error> {}
//}
