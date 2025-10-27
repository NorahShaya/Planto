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
    }

    func remove(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }

    // MARK: - Daily check API

    func toggleChecked(for plant: Plant) {
        guard let idx = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        if plants[idx].isCheckedToday {
            // Uncheck for today
            plants[idx].lastChecked = nil
        } else {
            // Check now
            plants[idx].lastChecked = Date()
        }
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

    // Legacy total events (kept if you referenced it elsewhere)
    var totalWaterEvents: Int {
        checkedCount
    }
}

