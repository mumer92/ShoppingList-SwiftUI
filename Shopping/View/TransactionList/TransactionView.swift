//
//  TransactionView.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    let transaction: TransactionModel
    var isPinned: Bool
    
    var body: some View {
        VStack {
            HeaderView(
                category: transaction.category.rawValue,
                color: transaction.category.color,
                isPinned: isPinned,
                action: { print("yes") }
            )
            
            if isPinned {
                DetailView(transaction: transaction)
            }
        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

struct DetailView: View {
    let transaction: TransactionModel
    
    var body: some View {
        HStack {
            transaction.image
                .resizable()
                .frame(width: 60.0, height: 60.0, alignment: .top)
            
            VStack(alignment: .leading) {
                Text(transaction.name)
                    .secondary()
                Text(transaction.accountName)
                    .tertiary()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(transaction.amount.formatted())")
                    .bold()
                    .secondary()
                Text(transaction.date.formatted)
                    .tertiary()
            }
        }
        .padding()
    }
}

struct HeaderView: View {
    let category: String
    let color: Color
    var isPinned: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(category)
                .font(.headline)
                .foregroundColor(color)
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: isPinned ? "pin.fill" : "pin.slash.fill")
            }
        }
    }
}

#if DEBUG
#Preview {
    VStack {
        TransactionView(transaction: ModelData.sampleTransactions[0], isPinned: false)
        TransactionView(transaction: ModelData.sampleTransactions[1], isPinned: true)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
#endif
