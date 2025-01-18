import FirebaseFirestore
import FirebaseAuth
import Foundation

class SecondRegistrationViewViewModel: ObservableObject {
    @Published var user: User
    @Published var errorMessage = ""
    
    @Published var weight = ""
    @Published var height = ""
    @Published var name = ""
 
    init(user: User) {
        self.user = user
    }
    
    private func insertUserRecord(id: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users")
                .document(id)
                .setData(user.asDictionary()) { error in
                    if let error = error {
                        print("Error writing user record to Firestore: \(error.localizedDescription)")
                    }
                }
    }
    
    func completeRegistration() {
        guard validate() else {
            return
        }
        
        user.name = self.name
        user.height = Int(self.height)!
        user.weight = Int(self.weight)!
        
        print(user)

        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            guard let userId = result?.user.uid else {
                print("Error: result is nil, user ID could not be retrieved.")
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !weight.trimmingCharacters(in: .whitespaces).isEmpty,
              !height.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please, fill in all the fields"
            return false
        }
        
        guard let _ = Int(height),
              let _ = Int(weight)
        else {
            errorMessage = "Please, enter the correct weight and height"
            return false
        }

        
        return true
    }

}
    
