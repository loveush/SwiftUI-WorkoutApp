import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(background)
                    
                Text(title)
                    .foregroundStyle(Color(.white))
            }
        }
    }
}

#Preview {
    TLButton(title: "title", background: .pink) {
        //action
    }
}
