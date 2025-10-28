//
//  EditSheet.swift
//  Planto
//
//  Created by Norah Aldawsari on 28/10/2025.
//

import SwiftUI

struct EditSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: PlantStore

    // The plant being edited
    let plant: Plant

    // Local editable copies
    @State private var plantName: String
    @State private var selectedRoom: roomType
    @State private var selectedWatering: wateringDays
    @State private var selectedWater: waterAmount
    @State private var lightingType: lighting

    init(plant: Plant) {
        self.plant = plant
        _plantName = State(initialValue: plant.name)
        _selectedRoom = State(initialValue: plant.room)
        _selectedWatering = State(initialValue: plant.watering)
        _selectedWater = State(initialValue: plant.waterAmount)
        _lightingType = State(initialValue: plant.light)
    }

    var body: some View {
        ZStack {
            Color("sheetbg")
                .ignoresSafeArea()

            VStack {
                VStack(spacing: 10) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 17, weight: .regular))
                                .padding(4)
                        }
                        .buttonStyle(.glass)
                        .clipShape(Circle())
                        .padding(.leading, 20)

                        Spacer()

                        Text("Set Reminder")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.white)

                        Spacer()

                        Button(action: save) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 17, weight: .regular))
                                .padding(4)
                        }
                        .buttonStyle(.glassProminent)
                        .clipShape(Circle())
                        .tint(Color("Greeno"))
                        .padding(.trailing, 20)
                    }

                    Spacer()

                    // Form group 1
                    VStack {
                        HStack {
                            Spacer()
                            Text("Plant name")
                                .padding(2)
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(Color.white)

                            TextField("Pothos", text: $plantName)
                                .foregroundStyle(Color.white.opacity(0.8))
                                .tint(Color.green)
                                .font(.system(size: 18, weight: .regular))
                        }
                        .frame(height: 60)
                        .background(Color("Formgroup"))
                        .cornerRadius(30)

                        Spacer()

                        // Form group 2: Room + Light
                        VStack {
                            HStack {
                                HStack {
                                    Image(systemName: "location")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 18, weight: .regular))
                                    Text("Room")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundStyle(Color.white)
                                }

                                Spacer()

                                Picker("selectedroom", selection: $selectedRoom) {
                                    ForEach(roomType.allCases) { room in
                                        Text(room.rawValue).tag(room)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.gray)
                            }
                            .padding(.trailing, 12)
                            .padding(.leading, 12)
                            .padding(6)

                            Divider()
                                .frame(height: 0.5)
                                .background(Color.gray.opacity(0.3))

                            HStack {
                                Image(systemName: "sun.max")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18, weight: .regular))
                                Text("Light")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color.white)
                                Spacer()
                                HStack {
                                    Picker("selectedlight", selection: $lightingType) {
                                        ForEach(lighting.allCases) { light in
                                            Text(light.rawValue).tag(light)
                                        }
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.gray)
                            }
                            .padding(.trailing, 12)
                            .padding(.leading, 12)
                            .padding(6)
                        }
                        .background(Color("Formgroup"))
                        .cornerRadius(30)
                        .padding(.trailing, 6)
                        .padding(.leading, 6)

                        // Form group 3: Watering + Amount
                        VStack {
                            HStack {
                                HStack {
                                    Image(systemName: "drop")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 18, weight: .regular))
                                    Text("Watering days")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                }

                                Picker("selectedwatering", selection: $selectedWatering) {
                                    ForEach(wateringDays.allCases) { days in
                                        Text(days.rawValue).tag(days)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.gray)
                            }
                            .padding(.trailing, 12)
                            .padding(.leading, 12)
                            .padding(6)

                            Divider()
                                .frame(height: 0.5)
                                .background(Color.gray.opacity(0.3))

                            HStack {
                                Image(systemName: "drop")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18, weight: .regular))
                                Text("Water")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color.white)
                                Spacer()

                                HStack {
                                    Picker("selectedwater", selection: $selectedWater) {
                                        ForEach(waterAmount.allCases) { amount in
                                            Text(amount.rawValue).tag(amount)
                                        }
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.gray)
                            }
                            .padding(.trailing, 12)
                            .padding(.leading, 12)
                            .padding(6)
                        }
                        .background(Color("Formgroup"))
                        .cornerRadius(30)
                        .padding(.trailing, 3)
                        .padding(.leading, 3)
                        .padding(.top, 25)

                        // Delete button
                        Button(role: .destructive, action: deletePlant) {
                            Text("Delete Reminder")
                                .foregroundStyle(Color.red) // red text
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity, minHeight: 54)
                            
                        }
                        
                        .buttonStyle(.plain) // avoid system tint override
                        .background(Color("Formgroup"))
                        .cornerRadius(30)
                        .padding(.horizontal, 24)

                        Spacer().frame(height: 300)
                    }
                }
            }
        }
    }

    private func save() {
        // Build updated copy and persist via store.update
        var updated = plant
        updated.name = plantName
        updated.room = selectedRoom
        updated.watering = selectedWatering
        updated.waterAmount = selectedWater
        updated.light = lightingType

        store.update(updated)
        dismiss()
    }

    private func deletePlant() {
        store.remove(plant)
        dismiss()
    }
}

#Preview {
    EditSheet(plant: Plant(name: "Pothos", room: .bedroom, light: .full, watering: .everyDay, waterAmount: .oneMl))
        .environmentObject(PlantStore())
        .preferredColorScheme(.dark)
}
