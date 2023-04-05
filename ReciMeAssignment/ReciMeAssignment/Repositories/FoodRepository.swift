//
//  FoodRepository.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 05/04/2023.
//

import Combine

protocol IFoodRepository: AnyObject {
    func listFoods() -> AnyPublisher<[Food], Error>
}

class FoodRepository: IFoodRepository {
    private var services: IJSONServices?
    private var cancellables = Set<AnyCancellable>()
    
    @discardableResult
    func listFoods() -> AnyPublisher<[Food], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            Task.detached(priority: .userInitiated) { [weak self] in
                guard let self = self else { return }
                self.services?.get([Food].self, from: "data.json")
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            print("[DEBUG] Error: \(error)")
                        case .finished:
                            print("[DEBUG] Finished")
                        }
                    } receiveValue: { foods in
                        promise(.success(foods))
                    }
                    .store(in: &self.cancellables)
            }
        }.eraseToAnyPublisher()
    }
}
