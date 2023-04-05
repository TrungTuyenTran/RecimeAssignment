//
//  ListViewModel.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 04/04/2023.
//

import Combine

protocol IAlertState {
    var errorTitle: String { get }
    var errorMessage: String { get }
    var errorAlertPresenting: Bool { get }
    
    func showAlert(title: String, message: String)
}

class ListViewModel: ObservableObject, IAlertState {
    @Published var errorTitle: String
    @Published var errorMessage: String
    @Published var errorAlertPresenting: Bool
    @Published var data: [Food]
    @Published var selection: String
    
    private var repository: IFoodRepository
    private var cancellables: Set<AnyCancellable>
    
    init(repository: IFoodRepository) {
        self.repository = repository
        errorTitle = ""
        errorMessage = ""
        errorAlertPresenting = false
        data = []
        selection = "None"
        cancellables = Set<AnyCancellable>()
    }
    
    func updateCallback() {
        repository.listFoods()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { foods in
                Task { @MainActor in
                    self.data = foods
                }
            }
            .store(in: &cancellables)
    }
    
    func arrange() -> [Food] {
        data.sorted(by: { $0.position <= $1.position })
    }
    
    func showAlert(title: String, message: String) {
        Task { @MainActor in
            self.errorTitle = title
            self.errorMessage = message
            self.errorAlertPresenting = true
        }
    }
}
