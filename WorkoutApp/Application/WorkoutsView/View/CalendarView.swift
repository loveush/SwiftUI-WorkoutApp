//
//  CalendarView.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 19.01.2025.
//

import SwiftUI

struct CalendarView: View {
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @Binding var days: [Date]
    
    @ObservedObject var viewModel: WorkoutsViewViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysOfWeek, id: \.self) { dayOfWeek in
                    Text(dayOfWeek)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("text"))
                        .frame(maxWidth: .infinity)
                        .opacity(0.6)
                }
            }
            Divider()
                .frame(minHeight: 1)
                .background(Color("pink"))
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != viewModel.date.monthInt {
                        Text("")
                    } else {
                        let hasWorkouts = viewModel.hasWorkouts(day: day)
                        
                        Text(day.formatted(.dateTime.day()))
                            .font(.system(size: 18))
                            .foregroundStyle(Color("text"))
                            .frame(maxWidth: .infinity, minHeight: 35)
                            .background(
                                day.startOfDay == Date.now.startOfDay ?
                                Circle()
                                    .fill(Color("pink"))
                                    .frame(width: 40, height: 40)
                                    .opacity(0.6)
                                    .shadow(radius: 2, y: 2) : nil
                            )
                            .background(
                                viewModel.date == day ?
                                Circle()
                                    .fill(Color("pink"))
                                    .frame(width: 40, height: 40)
                                    .opacity(0.4) : nil
                            )
                            .overlay(alignment: .top) {
                                if hasWorkouts {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .onTapGesture {
                                viewModel.date = day
                            }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("darkpink"))
        )
    }
}

