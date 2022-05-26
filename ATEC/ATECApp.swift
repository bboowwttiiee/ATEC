//
//  ATECApp.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

@main
struct ATECApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
        }
    }
}
