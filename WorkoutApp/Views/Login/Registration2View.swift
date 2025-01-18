import SwiftUI

struct Registration2View: View {
    @State var weight:String = ""
    @State var height = ""
    @State var name = ""
    
    @ObservedObject var viewModel: SecondRegistrationViewViewModel
    
    var body: some View {
        ZStack {
            LoginBackgroundView()
                .frame(width: UIScreen.main.bounds.width)
            
            VStack {
                Spacer(minLength: 150)
                
                Text("Ваши данные")
                    .font(.title)
                    .foregroundColor(Color("text"))
                
                Spacer()
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Как вас зовут?")
                            .foregroundColor(Color("text"))
                        Spacer()
                    }
                    .offset(x:40)
                    CustomTextField(text: $name, placeholder: "Введите имя..")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                    
                    HStack {
                        Text("Ваш рост")
                            .foregroundColor(Color("text"))
                        Spacer()
                    }
                    .offset(x:40)
                    CustomTextField(text: $height, placeholder: "Введите рост...")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                    
                    HStack {
                        Text("Ваш вес")
                            .foregroundColor(Color("text"))
                        Spacer()
                    }
                    .offset(x:40)
                    CustomTextField(text: $weight, placeholder: "Введите вес...")
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(Color.red)
                    }
                }
                
                Spacer(minLength: 120)
                
                TLButton(title: "Завершить", background: Color("darkpink")) {
                    if viewModel.validate(name: name, weight: weight, height: height) {
                        if let heightValue = Int(height),
                           let weightValue = Int(weight) {
                            viewModel.completeRegistration(name: name,
                                                           height: heightValue,
                                                           weight: weightValue)
                        } else {
                            viewModel.errorMessage = "Please, enter the correct weight and height"
                        }
                    }
                }
                .frame(width: 180, height: 55)
                
                Spacer()
                        
            }
        }
    }
}

#Preview {
    Registration2View(viewModel: SecondRegistrationViewViewModel(user: User(id: "", email: "", password: "", name: "", height: 0, weight: 0, joined: 0)))
}
