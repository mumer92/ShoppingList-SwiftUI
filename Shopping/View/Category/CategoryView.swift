//
//  CategoryView.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 15/07/2022.
//

import SwiftUI

struct CategoryView: View {
    let category: String
    
    var body: some View {
        VStack {
            HStack {
                Text(category)
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
            }
        }
        .padding(6)
        .background(TransactionModel.Category(rawValue: category)?.color ?? .accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#if DEBUG
#Preview {
    VStack {
        CategoryView(category: TransactionModel.Category.entertainment.rawValue)
        CategoryView(category: TransactionModel.Category.food.rawValue)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
#endif

