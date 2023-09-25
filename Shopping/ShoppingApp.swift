//
//  ShoppingApp.swift
//  Shopping
//
//  Created by MuhammadUmer on 27/7/21.
//

import SwiftUI

@main
struct ShoppingApp: App {
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
