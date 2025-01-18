import FirebaseCore
import SwiftUI

@main
struct Daily_HelperApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
