//
//  ShoppingTests.swift
//  ShoppingTests
//
//  Created by MuhammadUmer on 30/7/21.
//

import XCTest
@testable import Shopping

class ShoppingTests: XCTestCase {
    
    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = ViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Category Filtering Tests
    
    /// Test to verify that transactions are filtered correctly based on the selected category.
    func testCategoryFiltering() {
        let selectedCategory = TransactionModel.Category.food.rawValue
        viewModel.selectedCategory = selectedCategory
        let filteredTransactions = viewModel.filteredTransactions()
        
        XCTAssertTrue(filteredTransactions.allSatisfy { $0.category.rawValue == selectedCategory }, "Not all transactions match the selected category.")
    }
    
    // MARK: - Pinning and Unpinning Tests
    
    /// Test to verify that transactions can be pinned and unpinned correctly.
    func testPinningUnpinningTransactions() {
        guard let transaction = viewModel.transactions.first else {
            XCTFail("No transactions available for testing.")
            return
        }
        
        viewModel.togglePin(transaction: transaction)
        XCTAssertFalse(viewModel.shouldPin(transaction: transaction), "Transaction should be unpinned.")
        
        viewModel.togglePin(transaction: transaction)
        XCTAssertTrue(viewModel.shouldPin(transaction: transaction), "Transaction should be pinned.")
    }
    
    // MARK: - Category Sum Calculation Tests
    
    /// Test to verify that the sum is calculated correctly for a given category.
    func testCalculateCategorySum() {
        let category = TransactionModel.Category.food
        let calculatedSum = viewModel.calculateCategorySum(category)
        
        let expectedSum = viewModel.transactions
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
        XCTAssertEqual(calculatedSum, expectedSum, "Calculated sum is incorrect.")
    }
    
    // MARK: - Sorting Tests
    
    /// Test to verify that transactions are sorted correctly by date.
    func testSortingOldestFirst() {
        viewModel.sortByDate(recentFirst: false)
        let sortedTransactions = viewModel.transactions
        let correctlySortedTransactions = ModelData.sampleTransactions.sorted(by: { $0.date < $1.date })
        
        XCTAssertEqual(sortedTransactions, correctlySortedTransactions, "The transactions array is not correctly sorted.")
    }
    
    // MARK: - Filtering Tests
    
    /// Test to verify that transactions are filtered correctly
    func testFilteringBasedOnCategory() {
        let category: TransactionModel.Category = .food
        viewModel.selectedCategory = TransactionModel.Category.food.rawValue
        let filteredTransactions = viewModel.filteredTransactions()
        
        XCTAssertTrue(filteredTransactions.allSatisfy { $0.category == category })
    }
    
    /// Test to verify that sum of transactions are filtered correctly
    func testSumOfTransactionsForFilteredCategory() {
        viewModel.selectedCategory = TransactionModel.Category.food.rawValue
        let amount = viewModel.calculateSelectedCategorySum()
        
        XCTAssertEqual(amount.formatted(), "74.28")
    }
    
    // MARK: - ViewModel Initialization Tests
    
    /// Test to verify that the ViewModel is initialized correctly.
    func testViewModelInitialization() {
        XCTAssertEqual(viewModel.transactions, ModelData.sampleTransactions, "Transactions should be initialized with sample transactions.")
        XCTAssertEqual(viewModel.selectedCategory, TransactionModel.Category.all, "Selected category should be initialized to 'all'.")
        XCTAssertTrue(viewModel.categories.contains(TransactionModel.Category.all), "Categories should contain 'all'.")
    }
    
    // MARK: - Performance Tests
    
    /// Test to measure the performance of sorting transactions by date.
    func testPerformanceExample() throws {
        let recentFirst = true
        
        measure {
            viewModel.sortByDate(recentFirst: recentFirst)
        }
    }
}
