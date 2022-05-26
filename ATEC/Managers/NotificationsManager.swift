//
//  NotificationsManager.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func reloadLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotifications(title: String, hour: Int, minute: Int, completion: @escaping (Error?) -> ()) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        
        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: completion)
    }
}

func calculateAge(fromDate: Date) -> String {
    let now = Date()
    let birthday: Date = fromDate
    let calendar = Calendar.current

    let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
    let age = ageComponents.year!
    
    return "\(age)"
}
