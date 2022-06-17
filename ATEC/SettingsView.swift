//
//  SettingsView.swift
//  ATEC
//
//  Created by bowtie on 31.05.2022.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @ObservedObject var notificationManager: NotificationManager
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @State private var notificationDate: Date = Date()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    // MARK: - DARKMODE
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Dark Mode")
                                .fontWeight(.semibold)
                            Text("Adjust favorite appearance")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } //: VSTACK
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle(isOn: $isDarkMode) {}
                            .labelsHidden()
                    } //: HSTACK
                    .padding()
                    .background(
                        ZStack {
                            Image(isDarkMode ? "night" : "day")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 73, alignment: .bottom)
                                .cornerRadius(15)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(isDarkMode ?
                                    .linearGradient(colors: [
                                        .black.opacity(0.7),
                                        .black.opacity(0.7),
                                        .black.opacity(0.65),
                                        .black.opacity(0.1),
                                        .black.opacity(0),
                                        .black.opacity(0)
                                    ], startPoint: .leading, endPoint: .trailing) :
                                        .linearGradient(colors: [
                                            .white.opacity(0.8),
                                            .white.opacity(0.8),
                                            .white.opacity(0.75),
                                            .white.opacity(0.3),
                                            .white.opacity(0),
                                            .white.opacity(0)
                                        ], startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(height: 73, alignment: .bottom)
                        }
                    )
                    
                    // MARK: - NOTIFICATIONS
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Notifications")
                                    .fontWeight(.semibold)
                                Text("Choose time for daily question")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } //: VSTACK
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle(isOn: $notificationManager.isNotificationsOn) {}
                                .labelsHidden()
                                .onChange(of: notificationManager.isNotificationsOn) { isTrue in
                                    if isTrue {
                                        notificationManager.reloadLocalNotifications()
                                    } else {
                                        notificationManager.isReminderSet = false
                                        notificationManager.deleteNotifications()
                                    }
                                }
                        } //: HSTACK
                        .padding()
                    } //: VSTACK
                    .frame(height: notificationManager.isNotificationsOn ? 250 : nil, alignment: notificationManager.isNotificationsOn ? .top : .center)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    .overlay {
                        if notificationManager.isNotificationsOn {
                            VStack {
                                Divider()
                                    .padding(.bottom)
                                Text("Tap on the clock and choose the time. When the time is selected, you will receive reminders about a short test every day at the same time.")
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                
                                Label {
                                    Text(notificationDate.formatted(date: .omitted, time: .shortened))
                                } icon: {
                                    if !notificationManager.isReminderSet {
                                        Image(systemName: "clock")
                                    } else {
                                        HStack {
                                            Image(systemName: "checkmark")
                                                .background(
                                                    Circle()
                                                        .fill(.green)
                                                        .frame(width: 25, height: 25)
                                                )
                                            Text("Set for:")
                                        }
                                        .font(.callout.bold())
                                        .onAppear {
                                            notificationManager.reloadLocalNotifications()
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical)
                                .background(
                                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                                        .fill(isDarkMode ? Color(UIColor.secondarySystemFill) : .white)
                                        .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                                )
                                .padding()
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    withAnimation {
                                        notificationManager.showTimePicker = true
                                    }
                                }
                            } //: VSTACK
                            .padding(.top, 58)
                            .padding(.horizontal)
                            .opacity(notificationManager.isNotificationsOn ? 1 : 0)
                            .frame(height: notificationManager.isNotificationsOn ? nil : 0)
                        }
                    } //: OVERLAY
                    
                    // MARK: - RESTART
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Restart the app")
                                .fontWeight(.semibold)
                            Text("Return to onboarding screen")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } //: VSTACK
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle(isOn: $isOnboarding) {}
                            .labelsHidden()
                    } //: HSTACK
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    
                    Spacer()
                } //: VSTACK
                .animation(.easeInOut, value: notificationManager.isNotificationsOn)
            } //: SCROLL
            .navigationTitle("Settings")
            .padding(.horizontal)
        } //: NAVIGATION
        .overlay {
            if notificationManager.showTimePicker {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationDate)
                            guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
                            notificationManager.createLocalNotifications(hour: hour, minute: minute) { error in
                                if error == nil {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            notificationManager.isReminderSet = true
                                            notificationManager.showTimePicker = false
                                        }
                                    }
                                }
                            }
                        }
                    
                    DatePicker.init(
                        "",
                        selection: $notificationDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.ultraThinMaterial)
                            .shadow(radius: 10)
                            .padding()
                    )
                    .onDisappear {
                        notificationManager.reloadLocalNotifications()
                    }
                } //: ZSTACK
            }
        } //: OVERLAY
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(notificationManager: NotificationManager())
    }
}
