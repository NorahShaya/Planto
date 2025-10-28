//
//  ContentView.swift
//  Planto
//
//  Created by Norah Aldawsari on 27/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet: Bool = false
    @EnvironmentObject var store: PlantStore  // ② access shared data

    // Selected plant for editing
    @State private var selectedPlant: Plant?

    var body: some View {
        ZStack {
            // Background
           

            VStack(spacing: 0) {
                // Title section
                VStack(alignment: .leading) {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading) // keep left aligned
                        .padding(.leading, 15)
                        .padding(.top, 60)

                    // Show divider only in empty state
                    if store.plants.isEmpty {
                        Divider()
                            .frame(height: 2)
                            .background(Color.gray.opacity(0.5))
                            .padding(.horizontal, 10)
                    }
                }

                // Water tracker header + progress
                if !store.plants.isEmpty && store.checkedCount != store.plants.count {
                    VStack(alignment: .center) {
                        Text(store.checkedCount == 0
                             ? "Your plants are waiting for a sip 💦"
                             : "\(store.checkedCount) of your plants feel loved today✨")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white.opacity(0.95))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)

                        ProgressView(value: store.progress)
                            .tint(Color("Greeno"))
                            .progressViewStyle(.linear)
                            .frame(height: 15)
                            .padding(.trailing, 16)
                            .padding(.leading, 16)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 4)
                }

                // Content section
                if store.plants.isEmpty {
                    // Empty state
                    VStack(spacing: 35) {
                        Image("PlantoDefault")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 200)
                            .padding(.top, 40)

                        Text("Start your plant journey!")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.white)

                        VStack {
                            Text("Now all your plants will be in one place and ")
                                .padding(.horizontal, 35)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("Textsecondary"))

                            Text("we will help you take care of them :)🪴")
                                .padding(.horizontal, 35)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("Textsecondary"))
                        }

                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("Set Plant Reminder")
                                .font(.system(size: 17, weight: .regular))
                                .frame(width: 280, height: 30)
                        }
                        .buttonStyle(.glassProminent)
                        .tint(Color("Greeno"))
                        .padding(.top, 40)

                        Spacer()
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                } else if store.checkedCount == store.plants.count {
                    // All done state
                    ZStack {
                        VStack(spacing: 20) {
                            Spacer()
                            Image("Group 4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 260)
                                .padding(.bottom, 8)

                            Text("All Done! 🎉")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.white)

                            Text("All Reminders Completed")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("Textsecondary"))

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                        // Floating add button also visible on "All Done"
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 17, weight: .regular))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.glassProminent)
                        .tint(Color("Greeno"))
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                    .transition(.opacity.combined(with: .scale))
                } else {
                    // Use a List so swipe actions appear
                    ZStack {
                        List {
                            ForEach(store.plants) { plant in
                                PlantRow(plant: plant)
                                    .environmentObject(store)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .listRowBackground(Color.clear)
                                    .contentShape(Rectangle()) // make entire row tappable
                                    .onTapGesture {
                                        selectedPlant = plant
                                    }
                            }
                            .onDelete(perform: store.remove)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)

                        // Floating add button bottom-right
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 17, weight: .regular))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.glassProminent)
                        .tint(Color("Greeno"))
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .allowsHitTesting(true)
                    }
                }
            }
        }
        .animation(.easeInOut, value: store.plants)
        .animation(.easeInOut, value: store.checkedCount)
        // Add new/edit sheet presentations
        .sheet(isPresented: $showSheet) {
            ReminderSheet()
                .environmentObject(store)
        }
        .sheet(item: $selectedPlant) { plant in
            EditSheet(plant: plant)
                .environmentObject(store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PlantStore())
        .preferredColorScheme(.dark)

}
