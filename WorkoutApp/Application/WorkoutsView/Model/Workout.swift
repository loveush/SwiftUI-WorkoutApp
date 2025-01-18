//
//  Workout.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 14.10.2024.
//
import SwiftData
import Foundation
import FirebaseFirestore


struct Workout: Codable, Identifiable {
    var id: String
    var name: String
    var type: String
    var startDate: Date
    var endDate: Date
    var comment: String
    
    init(id: String, name: String = "", type: String = "", startDate: Date, endDate: Date, comment: String = "") {
        self.id = id
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.comment = comment
    }
}
