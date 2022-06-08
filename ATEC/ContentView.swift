//
//  ContentView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var selectedTab: Tab = .peopleList
    @StateObject private var notificationManager = NotificationManager()
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                PeopleListView()
                    .tag(Tab.peopleList)
                SettingsView(notificationManager: notificationManager)
                    .tag(Tab.settings)
            } //: TAB
            
            CustomTabBarView(selectedTab: $selectedTab)
        } //: VSTACK
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        ContentView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
