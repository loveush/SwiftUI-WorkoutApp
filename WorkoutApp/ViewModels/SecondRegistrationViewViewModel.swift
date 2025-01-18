import FirebaseFirestore
import FirebaseAuth
import Foundation

class SecondRegistrationViewViewModel: ObservableObject {
    @Published var user: User
    @Published var errorMessage = ""
 
    
    init(user: User) {
        self.user = user
    }
    
    func completeRegistration(name: String, height: Int, weight: Int) {
        user.name = name
        user.height = height
        user.weight = weight
        
        // Try to create the user with Firebase Authentication
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            // Ensure result is not nil and retrieve the user ID
            guard let userId = result?.user.uid else {
                print("Error: result is nil, user ID could not be retrieved.")
                return
            }
            
            // Call the function to insert the user record into Firestore
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users")
                .document(id)
                .setData(user.asDictionary()) { error in
                    if let error = error {
                        print("Error writing user record to Firestore: \(error.localizedDescription)")
                    } else {
                        print("User record successfully written!")
                    }
                }
    }
    
    func validate(name: String, weight: String, height: String) -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !weight.trimmingCharacters(in: .whitespaces).isEmpty,
              !height.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please, fill in all the fields"
            return false
        }
        
        return true
    }

}
    
