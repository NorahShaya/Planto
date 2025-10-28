//
//  PlantStore.swift
//  Planto
//
//  Created by Norah Aldawsari on 23/10/2025.
//

import Foundation
import SwiftUI
import Combine

final class PlantStore: ObservableObject {
    @Published private(set) var plants: [Plant] = []

    func add(_ plant: Plant) {
        plants.append(plant)
        Task {
            try? await NotificationManager.requestAuthorizationIfNeeded()
            try? await NotificationManager.scheduleWatering(for: plant)
        }
    }

    func update(_ plant: Plant) {
        guard let idx = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[idx] = plant
        Task {
            try? await NotificationManager.requestAuthorizationIfNeeded()
            try? await NotificationManager.scheduleWatering(for: plant)
        }
    }

    func remove(at offsets: IndexSet) {
        let ids = offsets.map { plants[$0].id }
        plants.remove(atOffsets: offsets)
        Task {
            for id in ids {
                await NotificationManager.cancel(for: id)
            }
        }
    }

    // Remove a specific plant
    func remove(_ plant: Plant) {
        if let idx = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: idx)
            Task { await NotificationManager.cancel(for: plant.id) }
        }
    }

    // Clear all plants
    func clearAll() {
        let ids = plants.map { $0.id }
        plants.removeAll()
        Task {
            for id in ids {
                await NotificationManager.cancel(for: id)
            }
        }
    }

    // MARK: - Daily check API

    func toggleChecked(for plant: Plant) {
        guard let idx = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        if plants[idx].isCheckedToday {
            plants[idx].lastChecked = nil
        } else {
            plants[idx].lastChecked = Date()
        }
        // We do not change the schedule when checking off for today; watering cadence remains.
    }

    func resetToday() {
        for i in plants.indices {
            plants[i].lastChecked = nil
        }
    }

    var checkedCount: Int {
        plants.filter { $0.isCheckedToday }.count
    }

    var progress: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(checkedCount) / Double(plants.count)
    }

    var totalWaterEvents: Int {
        checkedCount
    }
}
