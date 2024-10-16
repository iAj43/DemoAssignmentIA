//
//  Constants.swift
//  DemoAssignmentIA
//
//  Created by IA on 16/10/24.
//

import Foundation
//
// MARK: - Constants
//
enum Constants {
    
    static let waitingSecond: Double = 5
    
    // MARK: - String
    enum Strings {
        static let scheduleCustomNotification = "Schedule Custom Notification"
        static let scheduleIncomingCallNotification = "Schedule Incoming Call Notification"
        static let notesTitle = "Note: You will get notifies in"
        static let seconds = "seconds"
        static let decline = "Decline"
        static let accept = "Accept"
        static let incomingCall = "Incoming Call"
        static let incomingCallFrom = "Incoming call from"
        static let customBannerNotification = "This is a custom banner notification"
    }
    
    // MARK: - Identifiers
    enum Identifiers {
        static let notificationCategory = "CustomNotificationCategory"
        static let notificationRequest = "LocalNotification"
    }
    
    // MARK: - Image
    enum Images {
        static let iconDecline = "ic_decline"
        static let iconAccept = "ic_accept"
    }
}
