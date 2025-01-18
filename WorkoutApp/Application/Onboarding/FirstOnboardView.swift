import SwiftUI

struct FirstOnboardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardBackground()
                    .frame(width: UIScreen.main.bounds.width)
                
                VStack {
                    Text("DailyHelper")
                        .font(.body)
                        .foregroundColor(Color("darkpink"))
                        .offset(y:25)
                    Spacer(minLength: 110)
                    Image("balancering")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(1.7, contentMode: .fit)
                        .offset(x:-22, y:10)
                    
                    Spacer()
                    VStack (spacing: 12) {
                        Text("Следите за потреблением воды")
                            .foregroundColor(Color("text"))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                        Text("Мы рассчитаем дневную дозу воды, в которой нуждается ваш организм, и будем отправлять вам напоминания")
                            .font(.system(size: 16))
                            .padding(.horizontal, 40)
                    }
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    Spacer()
                    
                    VStack (spacing: 15) {
                        CustomNavigationLink(destination: SecondOnboardView(),
                                             title: "Далее")
                        .frame(width: 180, height: 55)
                        NavigationLink(destination: LoginView()) {
                            Text("У меня уже есть аккаунт")
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer(minLength: 80)
                }
            }
        }
    }
}

#Preview {
    FirstOnboardView()
}
