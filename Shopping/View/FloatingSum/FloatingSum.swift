//
//  FloatingSum.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 16/07/2022.
//

import SwiftUI

struct FloatingSum: View {
    let category: String
    let sum: Double
    
    var body: some View {
        VStack {
            HStack {
                TotalSpentView()
                
                Spacer()
                
                CategorySumView(category: category, sum: sum)
            }
            .padding(8)
        }
        .frame(height: 60)
        .padding(8)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.accentColor, lineWidth: 2)
        )
    }
}

struct TotalSpentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Total spent:")
                .secondary()
        }
    }
}

struct CategorySumView: View {
    let category: String
    let sum: Double
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(category)
                .bold()
                .foregroundColor(TransactionModel.Category(rawValue: category)?.color ?? Color.accentColor)
                .font(.headline)
            
            Spacer()
            
            Text("$\(sum.formatted())")
                .bold()
                .secondary()
        }
    }
}

#if DEBUG
#Preview {
    VStack {
        FloatingSum(category: "food", sum: 100.50)
            .padding()
        FloatingSum(category: "all", sum: 500)
            .padding()
    }.previewLayout(.sizeThatFits)
}
#endif
