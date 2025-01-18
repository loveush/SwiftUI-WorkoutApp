import SwiftUI

struct RegistrationView: View {

    @StateObject var viewModel = RegistrationViewViewModel()
    @State private var navigateToSecondScreen = false
    @State private var user: User? = nil 
    
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
                        VStack(spacing: 15) {
                            CustomTextField(text: $viewModel.email,
                                            placeholder: "Задайте логин...")
                            CustomSecureField(text: $viewModel.password,
                                              placeholder: "Задайте пароль...")
                            CustomSecureField(text: $viewModel.repeat_password,
                                              placeholder: "Повторите пароль...")
                        }
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundStyle(Color.red)
                        }
                    Spacer()

                    }
                    VStack (spacing: 15) {

                        TLButton(title: "Далее", background: Color("darkpink")) {
                            if let createdUser = viewModel.createUser() {
                                self.user = createdUser
                                self.navigateToSecondScreen = true
                            }
                        }
                        .frame(width: 180, height: 55)
                        .navigationDestination(isPresented: $navigateToSecondScreen) {
                            SecondRegistrationView(viewModel: SecondRegistrationViewViewModel(user: user ?? User.defaultUser()))
                        }
                        
                        NavigationLink {
                            LoginView()
                        } label: {
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
