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

class JSONFileServices: IJSONServices {
    private var cancellable = Set<AnyCancellable>()
    
    func get<T: Codable>(_ type: T.Type, from fileName: String) -> AnyPublisher<T, Error> {
        Bundle.main.readFile(file: fileName)
            .flatMap { data -> AnyPublisher<T, Error> in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try decoder.decode(ResponseModel<T>.self, from: data)
                    return Just(response.data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } catch let error {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Bundle{
    func readFile(file: String) -> AnyPublisher<Data, Error> {
        self.url(forResource: file, withExtension: "json")
            .publisher
            .tryMap{ string in
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(file) from bundle.")
                }
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
}
