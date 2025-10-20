//
//  ContentView.swift
//  Planto
//
//  Created by Norah Aldawsari on 27/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            
            //start of title section
            VStack(alignment: .leading){
                Text("My Plants 🌱")
                    .padding(.leading, 15)
                    .padding(.top, 60)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                Divider()
                .frame(height: 2)               // thickness
                .background(Color.gray.opacity(0.5))
                .padding(.leading, 10)
                .padding(.trailing, 10)

                Spacer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
             
            }//end of title section
            
            
            
            
            //Start of middle section
            VStack(spacing: 35){
                Image("PlantoDefault")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 200)
                    .padding(.top, 40)

                
                Text("Start your plant journey!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                
                //START OF GROUPED TEXT MIDDLE SECTION
                VStack{
                    Text("Now all your plants will be in one place and ")
                        .padding(.trailing, 35)
                        .padding(.leading, 35)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Textsecondary"))
                    
                    
                    Text("we will help you take care of them :)🪴")
                        .padding(.trailing, 35)
                        .padding(.leading, 35)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Textsecondary"))

                }//END OF GROUPED TEXT MIDDLE SECTION
                
                
                Button {
                    // action
                } label: {
                    Text("Set Plant Reminder")
                        .font(.system(size: 17, weight: .regular))
                        .frame(width: 280, height: 30) // <- size the label BEFORE the style
                }
                .buttonStyle(.glassProminent)
                .tint(Color("Green"))
                .padding(.top, 40)
             
         
            }//end of middle section
            
        
            Spacer()
            
      
            
            
            
            
            
            
            
            
            
       
        }//end of ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        .background(Color("Background"))
    }
       



}


#Preview {
    ContentView()
}
