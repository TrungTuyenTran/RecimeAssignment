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
    private var services: IJSONServices
    private var cancellables: Set<AnyCancellable>
    
    init(service: IJSONServices) {
        self.services = service
        cancellables = Set<AnyCancellable>()
    }
    
    @discardableResult
    func listFoods() -> AnyPublisher<[Food], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            Task.detached(priority: .userInitiated) { [weak self] in
                guard let self = self else { return }
                self.services.get([Food].self, from: "data")
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            promise(.failure(error))
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
