//
//  ReciMeAssignmentApp.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 04/04/2023.
//

import SwiftUI

@main
struct ReciMeAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: createViewModel())
        }
    }
    
    func createViewModel() -> ListViewModel {
        let viewModel = ListViewModel(repository: FoodRepository(service: JSONFileServices()))
        viewModel.updateCallback()
        return viewModel
    }
}
