//
//  PlantoApp.swift
//  Planto
//
//  Created by Norah Aldawsari on 23/10/2025.
//
 
 
//
//  PlantoApp.swift
//  Planto
//
//  Created by Norah Aldawsari on 27/04/1447 AH.
//

import SwiftUI

@main
struct PlantoApp: App {
    @StateObject private var store = PlantStore()   // Create one shared instance

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)            // Inject into environment
                .preferredColorScheme(.dark)         // Force dark mode app-wide
        }
    }
}
