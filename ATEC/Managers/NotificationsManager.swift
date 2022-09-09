//
//  NotificationsManager.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import Foundation
import UserNotifications
import UIKit

final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    @Published var showTimePicker: Bool = false
    @Published var isNotificationsOn: Bool = false
    @Published var isReminderSet: Bool = false
    
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
    
    func deleteNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        DispatchQueue.main.async {
            self.notifications.removeAll()
        }
    }
    
    func createLocalNotifications(hour: Int, minute: Int, completion: @escaping (Error?) -> ()) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Daily Question"
        notificationContent.subtitle = "Answer one simple question. It will only take 10 seconds."
        notificationContent.body = "Some question text is going here..."
        notificationContent.badge = 1
        notificationContent.sound = .default
        
        let yesAnswer = UNNotificationAction(identifier: "yes", title: "Yes", options: .foreground)
        let noAnswer = UNNotificationAction(identifier: "no", title: "No", options: .foreground)
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        let categories = UNNotificationCategory(identifier: "actions", actions: [yesAnswer, noAnswer, cancel], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        
        notificationContent.categoryIdentifier = "actions"
        
        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: completion)
    }
}
