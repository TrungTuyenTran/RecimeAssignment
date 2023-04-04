//
//  ListItemView.swift
//  ReciMeAssignment
//
//  Created by Tran Tuyen on 05/04/2023.
//

import SwiftUI

struct ListItemView: View {
    var widthItem: Double
    var heightImage: Double
    var food: Food
    @Binding var selection: String
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: food.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .background()
                .frame(width: widthItem,
                       height: heightImage)
                .roundedCorner(20, corners: [.topLeft, .topRight])
                .clipped()
                
                HStack {
                    Text(food.name)
                        .foregroundColor(selection == food.level ? Color.blue : Color.black)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text(food.level)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.bottom, 10)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selection == food.level ? Color.blue : Color.black,
                                lineWidth: 2)
                )
        }
        .frame(width: widthItem)
    }
}
