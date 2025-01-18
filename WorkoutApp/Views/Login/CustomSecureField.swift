import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        SecureField("",
                  text: $text,
                  prompt: Text(placeholder)
            .foregroundColor(Color("lighttext")))
        .padding(15)
        .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .stroke(Color("darkpink"), lineWidth: 2)
                )
        .padding(.horizontal, 40)
        
    }
}

