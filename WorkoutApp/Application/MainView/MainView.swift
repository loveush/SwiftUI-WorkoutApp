import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
//        LoginView()
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            if #available(iOS 18.0, *) {
                TabView {
                    Tab("", systemImage: "figure.strengthtraining.functional") {
                        WorkoutsView(userId: viewModel.currentUserId)
                    }
                    
                    Tab("", systemImage: "person") {
                        ProfileView()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            RegistrationView()
        }
    }
}

#Preview {
    MainView()
}
