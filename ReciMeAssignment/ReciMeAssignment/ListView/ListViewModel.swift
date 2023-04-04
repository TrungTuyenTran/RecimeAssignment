//
//  ListViewModel.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 04/04/2023.
//

import UIKit

class ListViewModel: ObservableObject {
    
    @Published var data: [Food] = [Food(name: "Food A", level: "Easy", position: 1, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food B", level: "Medium", position: 3, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food C", level: "Easy", position: 2, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food D", level: "Hard", position: 5, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food E", level: "Medium", position: 4, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food F", level: "Medium", position: 6, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food G", level: "Hard", position: 7, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food H", level: "Easy", position: 9, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food I", level: "Hard", position: 8, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg"),
                                   Food(name: "Food K", level: "Medium", position: 10, image: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg")]
    @Published var selection: String = "None"
    
    init() {}
    
    func arrange() -> [Food] {
        data.sorted(by: { $0.position <= $1.position })
    }
}
