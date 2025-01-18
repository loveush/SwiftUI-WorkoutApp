import SwiftUI

struct RegistrationView: View {

    @StateObject var viewModel = RegistrationViewViewModel()
    @State private var navigateToSecondScreen = false
    @State private var user: User? = nil // Store the user to pass it to the second
    
    var body: some View {
        NavigationStack {
            ZStack {
                LoginBackgroundView()
                    .frame(width: UIScreen.main.bounds.width)
                
                VStack {
                    Spacer(minLength: 200)
                    
                    Text("Регистрация")
                        .font(.title)
                        .foregroundColor(Color("text"))
                    
                    Spacer(minLength: 30)
                    
                    VStack(spacing: 15) {
                        CustomTextField(text: $viewModel.email,
                                        placeholder: "Задайте логин...")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                        CustomSecureField(text: $viewModel.password,
                                          placeholder: "Задайте пароль...")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                        CustomSecureField(text: $viewModel.repeat_password,
                                          placeholder: "Повторите пароль...")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundStyle(Color.red)
                        }
                    Spacer()

                        
                    }
                    VStack (spacing: 15) {
                        NavigationLink(destination:
                                        Registration2View(viewModel: SecondRegistrationViewViewModel(user: user ?? User.defaultUser())),
                                       isActive: $navigateToSecondScreen) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color("darkpink"))
                                Text("Далее")
                                    .foregroundStyle(Color.white)
                            }
                        }
                                       .frame(width: 180, height: 55)
                                       .disabled(user == nil)
                                       .simultaneousGesture(TapGesture().onEnded {
                                           if let createdUser = viewModel.createUser() {
                                               self.user = createdUser // Pass the user to the next view
                                               self.navigateToSecondScreen = true
                                           }
                                       })
                        NavigationLink(destination: LoginView()) {
                            Text("У меня уже есть аккаунт")
                                .foregroundStyle(Color("darkpink"))
                        }
                    }
                    
                    Spacer(minLength: 30)
                    
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
