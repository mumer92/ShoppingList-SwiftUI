//
//  InsightsView.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    
                    Spacer()
                    
                    Text("$\(viewModel.calculateCategorySum(category).formatted())")
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
#Preview {
    InsightsView()
}
#endif
