import SwiftUI

struct WorkoutsView: View {
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    @StateObject var viewModel = WorkoutsViewViewModel()
    
    private let userId: String
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("pink")
                    .ignoresSafeArea()
                
                VStack {
                    // Header
                    HStack {
                        Text("Workouts")
                            .font(.title)
                            .foregroundStyle(Color("text"))
                        Spacer()
                        
                        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .offset(y:10)
                    .padding(.horizontal, 30)
                    
                    // Calendar view
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
                                    let hasWorkouts = viewModel.currentWorkouts.contains { workout in
                                        let startOfDay = Calendar.current.startOfDay(for: day)
                                        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
                                        return workout.startDate >= startOfDay && workout.startDate < endOfDay
                                    }
                                    
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
                                                .opacity(0.4): nil
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    // Workouts panel
                    HStack {
                        Text("Plan for the day:")
                            .font(.title3)
                            .foregroundStyle(Color("text"))
                        
                        Spacer()
                        
                        // Add workout button
                        Button {
                            viewModel.showingNewWorkoutItemView = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundStyle(Color("darkpink"))
                                .frame(width: 20, height: 20)
                        }
                        .sheet(isPresented: $viewModel.showingNewWorkoutItemView) {
                            NewWorkoutItemView(date: viewModel.date, newWorkoutItemPresented: $viewModel.showingNewWorkoutItemView)
                        }
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 5)
                    
                    // Workouts list
                    if viewModel.currentDayWorkouts.isEmpty {
                        Spacer()
                        Text("Add a workout")
                            .font(.largeTitle)
                            .foregroundStyle(Color("darkpink"))
                            .opacity(0.5)
                        Image(systemName: "plus.viewfinder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color("darkpink"))
                            .opacity(0.5)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack {
                                ForEach(viewModel.currentDayWorkouts) { workout in
                                    Button(action: {
                                        viewModel.showingEditWorkoutItemView = true
                                    }) {
                                        WorkoutItemView(workout: workout)
                                    }
                                    .sheet(isPresented: $viewModel.showingEditWorkoutItemView) {
                                        NewWorkoutItemView(newWorkoutItemPresented: $viewModel.showingEditWorkoutItemView, workout: workout)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .onAppear() {
                    days = viewModel.date.calendarDisplayDays
                    viewModel.fetchWorkouts(for: userId)
                }
                .onChange(of: viewModel.date) {
                    days = viewModel.date.calendarDisplayDays
                    viewModel.fetchWorkouts(for: userId)
                }
            }
        }
    }
}

#Preview {
    WorkoutsView(userId: "81D4B5BF-8651-4450-AD8A-76368FA06EC2")
}
