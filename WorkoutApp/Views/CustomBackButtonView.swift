import SwiftUI

struct CustomBackButtonView: View {
    // A reference to the environment to control the navigation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            // Custom back button
            Button(action: {
                // Dismiss the current view (navigate back)
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left") // Back arrow icon
                        .font(.title)
                    Text("Back") // Back button label
                        .font(.headline)
                        .background(Color("darkpink"))
                }
            }
            
            Spacer() // Space between back button and other content
            
            // Other elements on the same level
            Text("Custom Title")
                .font(.title2)
                .bold()
            
            Spacer() // Space to center the title
        }
        .padding()
    }
}
 
#Preview {
    CustomBackButtonView()
}
