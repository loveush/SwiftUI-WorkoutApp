import SwiftUI

struct SecondOnboardView: View {
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
                    Image("pills")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(2, contentMode: .fit)
                        .offset(y:30)
                    Spacer()
                    VStack (spacing: 12) {
                        Text("Вовремя принимайте таблетки")
                            .foregroundColor(Color("text"))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                        Text("Занесите все препараты в приложение, а мы будем отправлять уведомления")
                            .font(.system(size: 16))
                            .padding(.horizontal, 40)
                    }
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    Spacer()
                    
                    VStack (spacing: 15){
                        CustomNavigationLink(destination: ThirdOnboardView(),
                                             title: "Далее")
                        .frame(width: 180, height: 55)
                        NavigationLink(destination: LoginView()) {
                            Text("У меня уже есть аккаунт")
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer(minLength: 50)
                }
                
            }
            
        }
    }
}

#Preview {
    SecondOnboardView()
}
