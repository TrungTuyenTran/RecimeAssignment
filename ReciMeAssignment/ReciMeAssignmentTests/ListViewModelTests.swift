//
//  ListViewModelTests.swift
//  ReciMeAssignmentTests
//
//  Created by Tran Tuyen on 05/04/2023.
//

import XCTest
import Combine
@testable import ReciMeAssignment

final class ListViewModelTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testArrangeData() throws {
        let vm = ListViewModel(repository: FoodRepository(service: MockJSONFileServices()))
        vm.updateCallback()
        let data = vm.arrange()
        XCTAssertEqual(data[0].name == "Food A" && data[1].name == "Food C", true)
    }

}
