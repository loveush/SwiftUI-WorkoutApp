//
//  NewWorkoutItemView.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 20.10.2024.
//

import SwiftUI

struct NewWorkoutItemView: View {
    @StateObject var viewModel: NewWorkoutItemViewViewModel
    var date: Date

    @Binding var newWorkoutItemPresented: Bool
    
    // New workout
    init(date: Date, newWorkoutItemPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: NewWorkoutItemViewViewModel(startDate: date, endDate: date))
        self.date = date
        self._newWorkoutItemPresented = newWorkoutItemPresented
    }
    
    // Edit workout
    init(newWorkoutItemPresented: Binding<Bool>, workout: Workout) {
        self._newWorkoutItemPresented = newWorkoutItemPresented
        _viewModel = StateObject(wrappedValue: NewWorkoutItemViewViewModel(workout: workout))
        self.date = workout.startDate
    }
    
    var body: some View {
        ZStack {
            Color("pink")
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 30)
                
                // Header
                HStack {
                    Button {
                        newWorkoutItemPresented = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("darkpink"))
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    
                    Text("New workout")
                        .font(.title)
                        .foregroundStyle(Color("text"))
                    Spacer()
                    
                    Button {
                        viewModel.deleteWorkout()
                        newWorkoutItemPresented = false
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("darkpink"))
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal, 30)
                
                Form {
                    
                    // Title
                    Section(header: Text("Title")) {
                        TextField("Add title...", text: $viewModel.name)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .stroke(Color("darkpink"), lineWidth: 1))
                    
                    // Type
                    Section(header: Text("Type")) {
                        Picker("Type", selection: $viewModel.type) {
                            ForEach(viewModel.workoutTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .stroke(Color("darkpink"), lineWidth: 1))

                    // Time
                    Section(header: Text("Time")) {
                        VStack {
                            DatePicker("Start time",
                                       selection: $viewModel.startDate,
                                       displayedComponents: .hourAndMinute)

                            Divider()
                                .frame(minHeight: 1)
                                .background(Color("pink"))

                            DatePicker("End time",
                                       selection: $viewModel.endDate,
                                       displayedComponents: .hourAndMinute)
                        }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .stroke(Color("darkpink"), lineWidth: 1))

                    // Comment
                    Section(header: Text("Comment")) {
                        TextField("Add a comment...", text: $viewModel.comment)
                            .lineLimit(5)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .stroke(Color("darkpink"), lineWidth: 1))

                }
                .frame(height: 490)
                .foregroundColor(Color("text"))
                .tint(Color("darkpink"))
                .background(Color("pink"))
                .scrollContentBackground(.hidden)
                
                // Error message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(Color.red)
                }
                
                // Save button
                TLButton(title: "Save", background: Color("darkpink")) {
                    if viewModel.canSave {
                        viewModel.save()
                        newWorkoutItemPresented = false
                    }
                }
                .frame(width: 150, height: 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NewWorkoutItemView(
        date: Date(),
        newWorkoutItemPresented: .constant(true) // Pass constant binding for preview
    )
}
