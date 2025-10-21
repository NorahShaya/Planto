//
//  ReminderSheet.swift
//  Planto
//
//  Created by Norah Aldawsari on 29/04/1447 AH.
//

import SwiftUI

struct ReminderSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
    
    @State var selectedRoom: roomType = .bedroom
    @State var selectedWatering: wateringDays = .everyDay
    @State var selectedWater: waterAmount = .oneMl
    @State var lightingType: lighting = .full
    
    
    var body: some View {
        ZStack {

            Color("sheetbg")
                .ignoresSafeArea()

            
            VStack{
                
                HStack{
                    Button {
                                                
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 17, weight: .regular))
                            .padding(2)
                    }
                    .buttonStyle(.glass)
                    .padding(.leading, 20)

                    Spacer()

                    
                    Text("Set reminder")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Button {
                        
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 17, weight: .regular))
                            .padding(2)

                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("Green"))
                    .padding(.trailing, 20)

                    
                }
                Spacer()
                    .frame(height: 60)
                    
                
                //GROUP OF FORM
                VStack{
                    
                    //First form
                    HStack(spacing: 7 ){

                        Text("Plant name")
                            .padding(.leading, 20)
                            .font(Font.system(size: 18, weight: .regular))
                            .foregroundStyle(Color.white)
                        TextField("Pothos", text: .constant(""))
                            .foregroundStyle(Color.white.opacity(0.8))
                            .tint(Color.green) // changes cursor (insertion point) color
                            .font(Font.system(size: 18, weight: .regular))
                            .padding(.trailing, 20)
                        
                        
                    }//end of first form
                    .padding(18)
                    .background(Color("Formgroup"))
                    .cornerRadius(70)
                    .padding(.trailing, 12)
                    .padding(.leading, 12)

                    Spacer()
              

                    //second form
                    VStack{
                        //last commit here in the HSTACK 
                        HStack(spacing: 80){
                            HStack{
                                
                                Image(systemName: "location")
                                Text("Plant name")
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundStyle(Color.white)
                            }
                          
                        
                            // Right Picker (menu)
                            
                            Picker("selectedroom", selection: $selectedRoom){
                                
                                ForEach(roomType.allCases){ room in
                                    
                                    Text(room.rawValue).tag(room)}
   
                            }
                        
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                            
                        }
                        Divider()
                        .frame(height: 0.5)               // thickness
                        .background(Color.gray.opacity(0.3))
                     
                        
                        HStack{
                            Image(systemName: "location")
                            Text("name")
                                .padding(.leading, 20)
                                .font(Font.system(size: 18, weight: .regular))
                                .foregroundStyle(Color.white)
                            Spacer()
                        
                            // Right Picker (menu)
                            HStack{
                            Picker("selectedroom", selection: $selectedRoom){
                                
                                ForEach(roomType.allCases){ room in
                                    
                                    Text(room.rawValue).tag(room)}
   
                            }
                        }
                            .pickerStyle(.menu)
                            .tint(.gray) // color of the selected value and caret icon
                            
                        }
                        
                    
                        
                        
                        
                       
                        
                    }
                    .padding(18)
                    .background(Color("Formgroup"))
                    .cornerRadius(30)
                    .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .frame(width: .infinity)
                    
                
                    //end of second form
                }
                
                Spacer()
                .frame(height: 420)
                
            }
            .padding(.top, 30) //padding for ZStack

        }//end of ZStack
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)//body frame
    }
}

#Preview {
    ReminderSheet()
}
