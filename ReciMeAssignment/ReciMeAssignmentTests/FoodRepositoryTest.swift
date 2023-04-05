//
//  FoodRepositoryTest.swift
//  ReciMeAssignmentTests
//
//  Created by Tran Tuyen on 05/04/2023.
//

import XCTest
import Combine
@testable import ReciMeAssignment

final class FoodRepositoryTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testListFood() throws {
        let repo: IFoodRepository = FoodRepository(service: MockJSONFileServices())
        repo.listFoods()
            .sink { _ in
            } receiveValue: { data in
                XCTAssertEqual(data.first?.name ?? "", "Food A")
            }
    }

}

class MockJSONFileServices: IJSONServices {
    func get<T: Codable>(_ type: T.Type, from fileName: String) -> AnyPublisher<T, Error> {
        Future { promise in
            let data: [Food] = [Food(name: "Food A", level: "Easy", position: 1, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food B", level: "Medium", position: 3, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food C", level: "Easy", position: 2, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food D", level: "Hard", position: 5, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food E", level: "Medium", position: 4, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food F", level: "Medium", position: 6, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food G", level: "Hard", position: 7, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food H", level: "Easy", position: 9, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food I", level: "Hard", position: 8, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                Food(name: "Food K", level: "Medium", position: 10, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg")]
            promise(.success(data as! T))
        }
        .eraseToAnyPublisher()
    }
}
