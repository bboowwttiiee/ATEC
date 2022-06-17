//
//  MainView.swift
//  ATEC
//
//  Created by bowtie on 15.06.2022.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    init() {
        UITabBar.appearance().isHidden = true
    }
    @StateObject private var notificationManager = NotificationManager()
    @State var selectedTab: Tab = .peopleList
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                PeopleListView()
                    .tag(Tab.peopleList)
                QuestinarriePageView()
                    .tag(Tab.questinarrie)
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
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        MainView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
