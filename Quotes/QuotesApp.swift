//
//  QuotesApp.swift
//  Quotes
//
//  Created by Ali on 11/10/2023.
//

import SwiftUI
import SwiftData

@main
struct QuotesApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            // ExampleView()
            ContentView()
                .environmentObject(modelData)
        }
    }
}
