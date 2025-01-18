import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField("",
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


