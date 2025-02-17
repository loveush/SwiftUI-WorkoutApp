//
//  ProfileViewViewModel.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 18.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewViewModel: ObservableObject {
    
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument() { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    height: data["height"] as? Int ?? 0,
                    weight: data["weight"] as? Int ?? 0,
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
