//
//  NotificationManager.swift
//  Planto
//
//  Created by Norah Aldawsari on 28/10/2025.
//

import Foundation
import UserNotifications

// Minimal helpers kept so this file compiles even if models aren’t extended elsewhere.
extension wateringDays {
    var intervalDays: Int {
        switch self {
        case .everyDay: return 1
        case .everyTwo: return 2
        case .everyThree: return 3
        case .oneWeek: return 7
        case .everyTen: return 10
        case .twoWeek: return 14
        }
    }
}

extension Plant {
    var wateringIntervalDays: Int? { watering.intervalDays }
}

enum NotificationManager {
    static func requestAuthorizationIfNeeded() async throws {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        if settings.authorizationStatus == .notDetermined {
            _ = try await center.requestAuthorization(options: [.alert, .sound, .badge])
        }
    }

    // TEST: schedule a single notification in 5 seconds (non-repeating).
    static func scheduleWatering(for plant: Plant) async throws {
        let center = UNUserNotificationCenter.current()

        // Remove any previous pending notification for this plant
        await center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])

        let content = UNMutableNotificationContent()
        content.title = "Water \(plant.name)"
        content.body = "Test reminder (fires once after 5 seconds)."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: plant.id.uuidString,
                                            content: content,
                                            trigger: trigger)

        try await center.add(request)
    }

    static func cancel(for plantID: UUID) async {
        let center = UNUserNotificationCenter.current()
        await center.removePendingNotificationRequests(withIdentifiers: [plantID.uuidString])
    }
}
