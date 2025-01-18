import SwiftUI

struct ThirdOnboardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardBackground()
                    .frame(width: UIScreen.main.bounds.width)
                VStack {
                    Text("DailyHelper")
                        .font(.body)
                        .foregroundColor(Color("darkpink"))
                        .offset(y:-10)
                    Spacer()
                    Image("schedule")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(2.5, contentMode: .fit)
                        .offset(x:80, y: 40)
                    Spacer()
                    
                    VStack (spacing: 12) {
                        Text("Составляйте график\nтренировок")
                            .foregroundColor(Color("text"))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                            .padding(.horizontal, 22)
                        Text("Мы поможем вам отслеживать личный прогресс")
                            .font(.system(size: 16))
                            .padding(.horizontal, 40)
                    }
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .offset(y:20)
                    Spacer()
                    
                    VStack (spacing: 15){
                        CustomNavigationLink(destination: RegistrationView(),
                                             title: "Зарегистрироваться")
                        .frame(width: 230, height: 55)
                        NavigationLink(destination: LoginView()) {
                            Text("У меня уже есть аккаунт")
                                .foregroundStyle(.white)
                        }
                    }
                        
                    Spacer(minLength: 60)
                }
            }
        }
    }
}

#Preview {
    ThirdOnboardView()
}
