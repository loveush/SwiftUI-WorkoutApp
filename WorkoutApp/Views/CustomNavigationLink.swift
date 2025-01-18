import SwiftUI

struct CustomNavigationLink<Destination: View>: View {
    var destination: Destination
    var title: String
    
    let background: Color = Color("darkpink")

    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(background)

                Text(title)
                    .foregroundColor(Color(.white))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    CustomNavigationLink(destination: MainView(), title: "Click")
}
