//
//  WorkoutItemView.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 15.10.2024.
//

import SwiftUI

struct WorkoutItemView: View {
    let workout: Workout
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .frame(width: 6, height: 40)
                        .offset(x: 12)
                    
                    VStack(alignment: .leading) {
                        Text("\(workout.name)")
                            .font(.headline)
                        Text("\(workout.type)")
                            .opacity(0.8)
                    }
                    .foregroundStyle(Color("text"))
                    .padding(15)
                    
                    Spacer()
                    Text("\(workout.startDate, style: .time)")
                        .multilineTextAlignment(.trailing)
                        .padding(20)
                        .foregroundStyle(Color("text"))
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("darkpink"))
                        .frame(maxWidth: .infinity)
                )
                .padding(.horizontal, 20)
            }
            Spacer()
        }
    }
}

#Preview {
    WorkoutItemView(workout: Workout(id: "", name: "Morning Run", type: "Cardio", startDate: Date(), endDate: Date()))
}
