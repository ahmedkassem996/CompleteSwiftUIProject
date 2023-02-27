//
//  LocalPushNotifications.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 27/02/2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { succ, error in
            if let err = error {
                print("Error:- \(err)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "First Notification"
        content.subtitle = "local Notification"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 45
//        dateComponents.weekday = 6
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // location
        let coordinate = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct LocalPushNotifications: View {
    var body: some View {
        
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
}

struct LocalPushNotifications_Previews: PreviewProvider {
    static var previews: some View {
        LocalPushNotifications()
    }
}
