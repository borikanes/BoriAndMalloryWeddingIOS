//
//  NotificationHelper.swift
//  BoriAndMalloryWedding
//
//  Created by Chris Longe on 8/12/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHelper {
    
    let notifications: [NotificationDetail] = [
        NotificationDetail(title: "Church Ceremony",
                           subtitle: nil,
                           body: "The ceremony is about to begin at the UMD Chapel!",
                           triggerDate: DateComponents(month: 8, day: 18, hour: 10, minute: 50),
                           identifier: "Notification1"),
        NotificationDetail(title: "Hors d'oeurves",
                           subtitle: nil,
                           body: "Snacks are now being served at the banquet hall!",
                           triggerDate: DateComponents(month: 8, day: 18, hour: 10, minute: 28),
                           identifier: "Notification2"),
        NotificationDetail(title: "Traditional Ceremony",
                           subtitle: nil,
                           body: "The traditional Nigerian ceremony is about to begin at the banquet hall!",
                           triggerDate: DateComponents(month: 9, day: 17, hour: 17, minute: 02),
                           identifier: "Notification3"),
        NotificationDetail(title: "Lunch Time",
                           subtitle: nil,
                           body: "Lunch and Reception is happening now at the banquet hall!",
                           triggerDate: DateComponents(month: 9, day: 17, hour: 17, minute: 03),
                           identifier: "Notification4")
    ]
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func configureNotifications(onCompletion: @escaping () -> Void, onError: @escaping (String) -> Void) {
        
        notificationCenter.getNotificationSettings { (settings) in
            // Do not schedule notifications if not authorized.
            guard settings.authorizationStatus == .authorized else {
                // Notifications not allowed
                onError("Notifications not allowed...")
                return
            }
            
            let notificationDG = DispatchGroup()
            for notification in self.notifications {
                notificationDG.enter()
                self.notificationCenter.add(notification.request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                        print("Error: \(error), while setting up notification: \(notification)")
                        notificationDG.leave()
                    }
                    print("Notificaton: \(notification.identifier) configured")
                    notificationDG.leave()
                })
            }
            
            notificationDG.notify(queue: .main) {
                onCompletion()
            }
        }
    }
}
