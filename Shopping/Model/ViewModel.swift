//
//  ViewModel.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 17/07/2022.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var transactions: [TransactionModel] = []
    @Published var unpinnedTransactions: [TransactionModel] = []
    @Published var selectedCategory: String
    @Published var categories: [String] = []
    
    init() {
        self.unpinnedTransactions = []
        self.transactions = ModelData.sampleTransactions
        self.selectedCategory = TransactionModel.Category.all
        self.categories.append(selectedCategory)
        self.categories.append(contentsOf: TransactionModel.Category.allCases.map { $0.rawValue })
    }
    
    func sortByDate(recentFirst: Bool) {
        transactions = sort(recentFirst: recentFirst)
    }
    
    func filteredTransactions() -> [TransactionModel] {
        return filter(by: selectedCategory, transactions: transactions)
    }
    
    func shouldPin(transaction: TransactionModel) -> Bool {
        return !unpinnedTransactions.contains { $0.id == transaction.id }
    }
    
    func togglePin(transaction: TransactionModel) {
        if let _ = unpinnedTransactions.firstIndex(where: { $0.id == transaction.id }) {
            unpinnedTransactions.removeAll { $0.id == transaction.id }
        } else {
            unpinnedTransactions.append(transaction)
        }
    }
    
    func calculateSelectedCategorySum() -> Double {
        return sum(by: selectedCategory, transactions: transactions, unpinnedTransactions: unpinnedTransactions)
    }
    
    func calculateCategorySum(_ category: TransactionModel.Category) -> Double {
        return transactions
            .filter { transaction in
                return !unpinnedTransactions.contains { unpinnedTransaction in
                    transaction.id == unpinnedTransaction.id
                }
            }
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }
}

extension ViewModel {
    func sort(recentFirst: Bool) -> [TransactionModel]  {
        return transactions.sorted(by: {
            if recentFirst {
                return $0.date > $1.date
            } else {
                return $0.date < $1.date
            }
        })
    }
    
    func filter(by category: String, transactions: [TransactionModel]) -> [TransactionModel] {
        if category == TransactionModel.Category.all {
            return transactions
        }
        return transactions.filter { transaction in
            return transaction.category == TransactionModel.Category(rawValue: category)
        }
    }
    
    func filter(by category: TransactionModel.Category, transactions: [TransactionModel]) -> [TransactionModel] {
        return transactions.filter { $0.category == category }
    }
    
    func sum(by category: TransactionModel.Category, transactions: [TransactionModel]) -> Double {
        return filter(by: category, transactions: transactions)
            .reduce(0) { $0 + $1.amount }
    }
    
    func sum(by category: String, transactions: [TransactionModel]) -> Double {
        return filter(by: category, transactions: transactions)
            .reduce(0) { $0 + $1.amount }
    }
    
    func sum(by category: String, transactions: [TransactionModel], unpinnedTransactions: [TransactionModel]) -> Double {
        return transactions
            .filter { transaction in
                if unpinnedTransactions.contains(where: { $0.id == transaction.id }) {
                    return false
                } else if category == TransactionModel.Category.all {
                    return true
                }
                return transaction.category == TransactionModel.Category(rawValue: category)
            }
            .reduce(0) { $0 + $1.amount }
    }
}

extension TransactionModel.Category {
    static let all = "all"
}
