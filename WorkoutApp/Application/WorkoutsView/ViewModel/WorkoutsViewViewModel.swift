//
//  WorkoutsViewViewModel.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 14.10.2024.
//

import Foundation
import FirebaseFirestore

class WorkoutsViewViewModel: ObservableObject {
    @Published var date = Date.now
    @Published var showingNewWorkoutItemView = false
    @Published var showingEditWorkoutItemView = false
    @Published var currentWorkouts: [Workout] = []

    var currentDayWorkouts: [Workout] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return currentWorkouts.filter { workout in
            workout.startDate >= startOfDay && workout.startDate < endOfDay
        }
    }
    
    init() {}
    
    func fetchWorkouts(for userId: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("workouts")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching workouts: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No workouts found.")
                    return
                }

                // Parse the documents into your `Workout` model manually
                self.currentWorkouts = documents.compactMap { (document) -> Workout? in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let startDateTimestamp = data["startDate"] as? Double,
                          let endDateTimestamp = data["endDate"] as? Double,
                          let type = data["type"] as? String,
                          let comment = data["comment"] as? String else {
                        print("Error: Missing fields in document \(document.documentID)")
                        return nil
                    }

                    // Convert timestamps to Date
                    let startDate = Date(timeIntervalSinceReferenceDate: startDateTimestamp)
                    print("startDateTimestamp:\(startDateTimestamp)")
                    let endDate = Date(timeIntervalSinceReferenceDate: endDateTimestamp)

                    return Workout(
                        id: document.documentID,
                        name: name,
                        type: type,
                        startDate: startDate,
                        endDate: endDate,
                        comment: comment
                    )
                }
            }
    }

}
