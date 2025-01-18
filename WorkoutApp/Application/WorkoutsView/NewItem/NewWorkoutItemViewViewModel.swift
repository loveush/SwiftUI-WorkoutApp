//
//  NewWorkoutItemViewViewModel.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 20.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewWorkoutItemViewViewModel: ObservableObject {
    var currentWorkout: Workout?
    @Published var name = ""
    @Published var type = "Cardio"
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var comment = ""
    
    @Published var errorMessage = ""
    
    let workoutTypes: [String] = ["Cardio", "Strength", "Flexibility", "Balance"]
    
    // New workout
    init(startDate: Date = Date(), endDate: Date = Date()) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    // Edit workout
    init(workout: Workout) {
        currentWorkout = workout
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.name = workout.name
        self.type = workout.type
        self.comment = workout.comment
    }
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        if currentWorkout != nil {
            guard workoutModified else {
                return
            }
            // Edit model
            currentWorkout!.name = name
            currentWorkout!.type = type
            currentWorkout!.startDate = startDate
            currentWorkout!.endDate = endDate
            currentWorkout!.comment = comment
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(uId)
                .collection("workouts")
                .document(currentWorkout!.id)
                .setData(currentWorkout!.asDictionary(), merge: true)
            
        } else {
            // Create model
            let newId = UUID().uuidString
            let newWorkoutItem = Workout(
                id: newId,
                name: name,
                type: type,
                startDate: startDate,
                endDate: endDate,
                comment: comment
            )
            
            // Save model
            let db = Firestore.firestore()
            db.collection("users")
                .document(uId)
                .collection("workouts")
                .document(newId)
                .setData(newWorkoutItem.asDictionary())
        }
        
    }
    
    var workoutModified: Bool {
        guard self.name != currentWorkout!.name || self.type != currentWorkout!.type || self.startDate != currentWorkout!.startDate || self.endDate != currentWorkout!.endDate || self.comment != currentWorkout!.comment else {
            return false
        }
        return true
    }
    
    var canSave: Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter a title"
            return false
        }
        
        guard startDate < endDate else {
            errorMessage = "Please set the correct time"
            return false
        }
        
        return true
    }
    
    func deleteWorkout() {
        if currentWorkout != nil {
            guard let uId = Auth.auth().currentUser?.uid else {
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(uId)
                .collection("workouts")
                .document(currentWorkout!.id)
                .delete()
            
        } else { return }
    }
}
