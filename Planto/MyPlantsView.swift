//
//  MyPlantsView.swift
//  Planto
//
//  Created by Norah Aldawsari on 23/10/2025.
//

import SwiftUI

struct MyPlantsView: View {
    @EnvironmentObject var store: PlantStore
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.plants) { plant in
                    PlantRow(plant: plant)
                        .environmentObject(store)
                }
                .onDelete(perform: store.remove)
            }
            .navigationTitle("My Plants 🌱")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                ReminderSheet()
                    .environmentObject(store)
            }
        }
        VStack(alignment: .leading, spacing: 4) {
            Label("In Bedroom", systemImage: "location")
                .foregroundStyle(.secondary.opacity(0.7))
            Text("Monstera")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.white)
            HStack(spacing: 12) {
                Label("Full sun", systemImage: "sun.max")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color("Textyellow"))
                    .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                    .background(Color("Formgroup").opacity(0.8))
                    .cornerRadius(30)
                    .padding(2)
                Label("20-50 ml", systemImage: "sun.max")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color("Textblue"))
                    .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                    .background(Color("Formgroup").opacity(0.8))
                    .cornerRadius(30)
                    .padding(2)
            }
        }
        .padding(.vertical, 6)
    }
}

// Row with circular check and dimming
struct PlantRow: View {
    @EnvironmentObject var store: PlantStore
    let plant: Plant

    private var isChecked: Bool { plant.isCheckedToday }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left content grouped vertically
            VStack(alignment: .leading, spacing: 8) {
                // Room label on top
                Label(plant.room.rawValue, systemImage: "location")
                    .foregroundStyle(Color("Textprimary").opacity(0.50))

                // Name row with check button beside the name
                HStack(spacing: 14) { // increased spacing between button and name
                    Button {
                        store.toggleChecked(for: plant)
                    } label: {
                        ZStack {
                            if isChecked {
                                // Filled green circle with black checkmark
                                Circle()
                                    .fill(Color("Greeno"))
                                    .frame(width: 28, height: 28)

                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.black)
                            } else {
                                // Outlined circle
                                Circle()
                                    .strokeBorder(Color.white.opacity(0.6), lineWidth: 2)
                                    .frame(width: 28, height: 28)
                            }
                        }
                        .contentShape(Circle())
                    }
                    .padding(.trailing, 8) // extra gap to the right of the button
                    .buttonStyle(.plain) // keep custom look

                    Text(plant.name)
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }

                // Tags row below
                HStack(spacing: 12) {
                    Label(plant.light.rawValue, systemImage: "sun.max")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color("Textyellow"))
                        .padding(.trailing, 12)
                        .padding(.leading, 12)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                        .background(Color("Formgroup").opacity(0.8))
                        .cornerRadius(30)
                        .padding(2)

                    Label(plant.waterAmount.rawValue, systemImage: "drop")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color("Textblue"))
                        .padding(.trailing, 12)
                        .padding(.leading, 12)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                        .background(Color("Formgroup").opacity(0.8))
                        .cornerRadius(30)
                        .padding(2)
                }
                .padding(.leading, 8)
            }
            .opacity(isChecked ? 0.45 : 1.0) // dim when checked

            Spacer(minLength: 0)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MyPlantsView()
        .environmentObject(PlantStore())
        .preferredColorScheme(.dark)
}
