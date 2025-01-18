import Foundation

class RegistrationViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var repeat_password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func createUser() -> User? {
        guard validate() else {
            return nil
        }
        return User(id: UUID().uuidString,
                    email: email,
                    password: password,
                    name: "",
                    height: 0,
                    weight: 0,
                    joined: Date().timeIntervalSince1970)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !repeat_password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please, fill in all the fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please, enter the correct email"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password should be longer than 6 characters"
            return false
        }
        
        guard password == repeat_password else {
            errorMessage = "Passwords don't match"
            return false
        }
        
        return true
    }
}

