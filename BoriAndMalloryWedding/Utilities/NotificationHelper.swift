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
                           triggerDate: DateComponents(month: 9, day: 22, hour: 10, minute: 50),
                           identifier: "Notification1")
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
                    notificationDG.leave()
                })
            }
            
            notificationDG.notify(queue: .main) {
                onCompletion()
            }
        }
    }
}
