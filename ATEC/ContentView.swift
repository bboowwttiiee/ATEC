//
//  ContentView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    let persistentContainer = CoreDataManager.shared.persistentContainer
    @State var endAnimation: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Group {
                if isOnboarding {
                    OnboardingView()
                } else {
                    MainView()
                        .environment(\.managedObjectContext, persistentContainer.viewContext)
                }
            }
            .offset(y: endAnimation ? 0 : getRect().height)
            
            SplashScreenView(endAnimation: $endAnimation)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
