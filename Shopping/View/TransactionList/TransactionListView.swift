//
//  TransactionListView.swift
//  Shopping
//
//  Created by MuhammadUmer on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isAlertPresented = false
    
    var body: some View {
        VStack {
            CategoryScrollView(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
            
            TransactionList()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Transactions")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SortButton(isAlertPresented: $isAlertPresented)
                    }
                }
            
            FloatingSum(category: viewModel.selectedCategory, sum: viewModel.calculateSelectedCategorySum())
                .padding(.horizontal)
        }
    }
}

struct TransactionList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredTransactions()) { transaction in
                TransactionView(transaction: transaction, isPinned: viewModel.shouldPin(transaction: transaction))
                    .onTapGesture {
                        viewModel.togglePin(transaction: transaction)
                    }
            }
        }
        .animation(.easeIn)
        .listStyle(PlainListStyle())
    }
}

struct CategoryScrollView: View {
    @Binding var selectedCategory: String
    var categories: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    CategoryView(category: category)
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.accentColor.opacity(0.8))
        .frame(height: 60)
    }
}

struct SortButton: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isAlertPresented: Bool
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Button("Sort") {
                isAlertPresented.toggle()
            }
            .confirmationDialog("How would you like to sort?", isPresented: $isAlertPresented, actions: {
                Button("Most recent first") {
                    viewModel.sortByDate(recentFirst: true)
                }
                Button("Oldest first") {
                    viewModel.sortByDate(recentFirst: false)
                }
            })
        }
    }
}

extension String: Identifiable {
    public var id: Int {
        return hash
    }
}

#if DEBUG
#Preview {
    TransactionListView()
        .environmentObject(ViewModel())
}
#endif
