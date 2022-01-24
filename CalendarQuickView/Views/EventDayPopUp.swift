//
//  EventDayPopUp.swift
//  CalendarQuickView
//
//  Created by Deepak on 24/01/22.
//

import SwiftUI


struct EventDayPopUpView : View{
    let calendarDay: CalendarDayModel
    var body : some View{
        ZStack{
            VStack(alignment:.leading,spacing: 5){
                Text("Event Name").font(.title).padding(5).padding(.top, 10)
                Divider()
                Text("20 Jan 2022 20:00 to 24:00")
                    .font(.title3)
                    .padding(5)
                Text("Repeat Daily")
                    .font(.title3)
                    .padding(5)
                Divider()
                Text("Notes: You will see the notes here, or not depends on the size of your text")
                    .font(.body)
                    .padding(5)
                    .frame(width: 300, alignment: .leading)
                    .lineLimit(nil)
                
                Spacer()
            }
        }
    }
}
