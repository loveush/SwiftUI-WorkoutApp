import SwiftUI

struct LoginBackgroundView: View {
    static let gradientStart = Color("darkpink")
    static let gradientEnd = Color("pink")
    
    var body: some View {
        ZStack {
            Color("pink")
                .ignoresSafeArea()
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                    startPoint: .init(x: 0.5, y: 0.2),
                    endPoint: .init(x: 0.5, y: 1)
                ))
                .frame(width: UIScreen.main.bounds.width*2,
                       height: 500)
                .rotationEffect(Angle(degrees: -15))
                .offset(y: -250)
            
            Text("DailyHelper")
                .font(.body)
                .foregroundColor(Color.white)
                .offset(y:-360)
            
        }
    }
}

#Preview {
    LoginBackgroundView()
}
