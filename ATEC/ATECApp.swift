//
//  ATECApp.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

@main
struct ATECApp: App {
    // MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
    }
}
