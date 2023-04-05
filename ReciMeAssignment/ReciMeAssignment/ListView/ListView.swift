//
//  ListView.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 04/04/2023.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var viewModel: ListViewModel
    @State private var showingOptions = false
    
    var widthItem: Double {
        if (UIScreen.main.bounds.width - 60).truncatingRemainder(dividingBy: 2) == 0 {
            return (UIScreen.main.bounds.width - 60)/2.0
        }
        return (UIScreen.main.bounds.width - 61)/2.0
    }
    
    var heightImage: Double {
        widthItem*1.2
    }
    
    var header: some View {
        HStack {
            Text("Trending Recipes")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .lineLimit(1)
            Spacer()
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible())],
                          spacing: 15) {
                    Section( header: header) {
                        ForEach(viewModel.arrange(), id:\.self) { food in
                            ListItemView(widthItem: widthItem,
                                         heightImage: heightImage,
                                         food: food,
                                         selection: $viewModel.selection)
                        }
                    }
                    
                }
                          .toolbar {
                              Button("Filter") {
                                  showingOptions = true
                              }
                          }
                          .navigationBarTitle("Recipes", displayMode: .inline)
                          .padding(20)
            }
            .alert(viewModel.errorTitle,
                   isPresented: $viewModel.errorAlertPresenting,
                   actions: {
                Button("OK", role: .cancel) { }
            },
                   message: {
                Text(viewModel.errorMessage)
            })
            .confirmationDialog("Difficulty", isPresented: $showingOptions, titleVisibility: .visible, actions: {
                Button("Easy") {
                    viewModel.selection = "Easy"
                }
                
                Button("Medium") {
                    viewModel.selection = "Medium"
                }
                
                Button("Hard") {
                    viewModel.selection = "Hard"
                }
                Button("Cancel", role: .cancel) {
                    viewModel.selection = "None"
                }
            }, message: {
                Text("You can filter recipes by difficulty")
            })
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
