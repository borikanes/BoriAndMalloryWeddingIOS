//
//  NotificationDetail.swift
//  BoriAndMalloryWedding
//
//  Created by Chris Longe on 8/12/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationDetail {
    
    let triggerDate: DateComponents
    let identifier: String
    let content = UNMutableNotificationContent()
    let trigger: UNCalendarNotificationTrigger
    let request: UNNotificationRequest
    
    init(title: String, subtitle: String?, body: String, triggerDate: DateComponents, identifier: String) {
        self.triggerDate = triggerDate
        self.identifier = identifier
        self.content.title = title
        if let subtitle = subtitle {
            self.content.subtitle = subtitle
        }
        self.content.body = body
        self.content.sound = UNNotificationSound.default()  // Possible formats: .aiff, .wav, or .caf
        self.trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        self.request = UNNotificationRequest(identifier: self.identifier, content: self.content, trigger: self.trigger)
    }
}
