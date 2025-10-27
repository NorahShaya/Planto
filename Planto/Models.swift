//
//  Models.swift
//  Planto
//
//  Created by Norah Aldawsari on 23/10/2025.
//

import Foundation

enum roomType : String, CaseIterable, Identifiable {
    case bedroom = "Bedroom"
    case Living = "Living Room"
    case Kitchen = "Kitchen"
    case Balcony = "Balcony"
    case Bathroom = "Bathroom"
    var id: String { rawValue }
}

enum wateringDays: String, CaseIterable, Identifiable {
    case everyDay = "Everyday"
    case everyTwo = "Every 2 days"
    case everyThree = "Every 3 days"
    case oneWeek = "Once a week"
    case everyTen = "Every 10 days"
    case twoWeek = "Every 2 weeks"
    var id: String { rawValue}
}

enum waterAmount: String, CaseIterable, Identifiable {
    case oneMl = "20-50ml"
    case twoMl = "50-100ml"
    case threeMl = "100-200ml"
    case fourMl = "200-300ml"
    var id: String { rawValue}
}

enum lighting: String, CaseIterable, Identifiable {
    case full = "Full sun"
    case partial = "Partial sun"
    case lowLight = "Low light"
    var id: String{ rawValue }
}

struct Plant: Identifiable, Equatable {
    let id: UUID = UUID()
    var name: String
    var room: roomType
    var light: lighting
    var watering: wateringDays
    var waterAmount: waterAmount

    // Daily check state
    var lastChecked: Date? = nil

    // Computed: has this plant been checked today?
    var isCheckedToday: Bool {
        guard let lastChecked else { return false }
        return Calendar.current.isDateInToday(lastChecked)
    }
}

