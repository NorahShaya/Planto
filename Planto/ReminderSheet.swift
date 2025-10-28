//
//  ReminderSheet.swift
//  Planto
//
//  Created by Norah Aldawsari on 29/04/1447 AH.
//

import SwiftUI
import Foundation

struct ReminderSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var store: PlantStore   // access shared data

        @State var plantName = ""
        @State var selectedRoom: roomType = .bedroom
        @State var selectedWatering: wateringDays = .everyDay
        @State var selectedWater: waterAmount = .oneMl
        @State var lightingType: lighting = .full

    
    
    var body: some View {
        ZStack {

            Color("sheetbg")
                .ignoresSafeArea()

            VStack  {
                
            VStack (spacing : 10){
                
                HStack{
                    Button {
                        // Dismiss the sheet
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

                    
                    Text("Set reminder")
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
                  //.frame(height: 60)
                    
                
                //GROUP OF FORM
                VStack{
                    
                    //First form
                    HStack{
                       Spacer()
                        Text("Plant name")
                            .padding(2)
                            .font(Font.system(size: 18, weight: .regular))
                            .foregroundStyle(Color.white)
                        
                        TextField("Pothos", text: $plantName)
                            .foregroundStyle(Color.white.opacity(0.8))
                            .tint(Color.green) // changes cursor (insertion point) color
                            .font(Font.system(size: 18, weight: .regular))
                      //    .padding(.trailing, 20)
                        
                        
                    }//end of first form
                    .frame(height: 60)
                   //.padding(18)
                    .background(Color("Formgroup"))
                    .cornerRadius(30)
//                    .padding(.trailing, 6)
//                    .padding(.leading, 6)
                    

                    Spacer()
                    
              

                    //Second form
                    VStack{
                        HStack{
                            HStack{
                                
                                Image(systemName: "location")
                                    .foregroundStyle(.white)
                                    .font(Font.system(size: 18, weight: .regular))
                                
                                Text("Room")
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color.white)
                                
                            }
                            
                            Spacer()
                            // Right Picker (menu)
                            
                            Picker("selectedroom", selection: $selectedRoom){
                                
                                ForEach(roomType.allCases){ room in
                                    Text(room.rawValue).tag(room)}
                            }
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                         
                        }
                        .padding(.trailing, 12)
                      .padding(.leading, 12)
                        .padding(6)
                        
                        Divider()
                        .frame(height: 0.5)               // thickness
                        .background(Color.gray.opacity(0.3))
                        HStack{
                            Image(systemName: "sun.max")
                                .foregroundStyle(.white)
                                .font(Font.system(size: 18, weight: .regular))
                            Text("Light")
                                .font(Font.system(size: 18, weight: .regular))
                                .foregroundStyle(Color.white)
                            Spacer()
                            // Right Picker (menu)
                            HStack{
                            Picker("selectedroom", selection: $lightingType){
                                ForEach(lighting.allCases){ light in
                                    Text(light.rawValue).tag(light)}
                            }
                        }
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                            
                        }
                        .padding(.trailing, 12)
                      .padding(.leading, 12)
                      .padding(6)

                    }
                    
                    
               
                    .background(Color("Formgroup"))
                    .cornerRadius(30)
                    .padding(.trailing, 6)
                    .padding(.leading, 6)

                    
                //.padding(15)
                  //  Spacer().frame(height: 400)

                                        
     
                    //Third form
                    VStack{
                        //last commit here in the HSTACK
                        HStack{
                            HStack{
                                
                                Image(systemName: "drop")
                                    .foregroundStyle(.white)
                                    .font(Font.system(size: 18, weight: .regular))
                                Text("Watering days")
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color.white)
                                Spacer()
                            }
                            // Right Picker (menu)
                            
                            Picker("selectedroom", selection: $selectedWatering){
                                
                                ForEach(wateringDays.allCases){ days in
                                    Text(days.rawValue).tag(days)}
                            }
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                        }
                        .padding(.trailing, 12)
                      .padding(.leading, 12)
                      .padding(6)

        
                        Divider()
                        .frame(height: 0.5)               // thickness
                        .background(Color.gray.opacity(0.3))
                        HStack{
                            Image(systemName: "drop")
                                .foregroundStyle(.white)
                                .font(Font.system(size: 18, weight: .regular))
                            Text("Water")
                                .font(Font.system(size: 18, weight: .regular))
                                .foregroundStyle(Color.white)
                            Spacer()
                            
                        
                            // Right Picker (menu)
                            HStack{
                            Picker("selectedroom", selection: $selectedWater){
                                ForEach(waterAmount.allCases){ amount in
                                    Text(amount.rawValue).tag(amount)}
                            }
                        }
                            
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                          
                            
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
                    Spacer().frame(height: 320)

                   

                   
                    //.padding(15)
                    //end of second form
                }
                
             
                
                
                
                
                
                
                
                
                
                
                
            }
                
          //  .padding(.top, 30) //padding for ZStack

        }
           

            //end of ZStack
        
         
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
            //body frame
    }
        
        
    }
    
    private func save() {
        guard !plantName.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let newPlant = Plant(
            name: plantName,
            room: selectedRoom,
            light: lightingType,
            watering: selectedWatering,
            waterAmount: selectedWater
        )

        // If all existing plants are checked (Group 4 visible), clear them first
        if store.checkedCount == store.plants.count && !store.plants.isEmpty {
            store.clearAll()
        }

        store.add(newPlant)
        dismiss()
    }

}


#Preview {
    ReminderSheet()
        .environmentObject(PlantStore())
        .preferredColorScheme(.dark)

}

