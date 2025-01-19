import SwiftUI

struct WorkoutsView: View {
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
                            .foregroundStyle(.text)
                        Spacer()
                        
                        Button {
                            viewModel.date = Date.now
                        } label: {
                            Text(Date.now.formattedDate)
                                .font(.system(size: 20))
                        }
                    }
                    .offset(y:10)
                    .padding(.horizontal, 30)
                    
                    // Calendar view
                    CalendarView(days: $days, viewModel: viewModel)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    viewModel.addToMonth(value: 1)
                                }
                                
                                if value.translation.width > 0 {
                                    viewModel.addToMonth(value: -1)
                                }
                            }
                        )
                    
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
                        Text("You have no workouts")
                            .font(.system(size: 30))
                            .foregroundStyle(.darkpink)
                            .opacity(0.5)
                        Image(systemName: "figure.gymnastics")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.darkpink)
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
