import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("pink")
                    .ignoresSafeArea()
                
                VStack {
                    if let user = viewModel.user {
                        
                        HStack {
                            Text("My profile")
                                .foregroundStyle(Color("text"))
                                .font(.title)
                            
                            Spacer()
                            // Sign out
                            Button("Log out") {
                                viewModel.logOut()
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        VStack {
                            // Avatar
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140, height: 140)
                                .foregroundStyle(Color("darkpink"))
                                .opacity(0.7)
                            
                            // Info
                            Text("\(user.name)")
                                .font(.title3)
                                .foregroundStyle(Color("text"))
                                .bold()
                            
                            Divider()
                                .frame(minHeight: 1)
                                .background(Color("darkpink"))
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                            
                            HStack {
                                Text("\(user.height) cm")
                                Spacer()
                                Text("\(user.weight) kg")
                            }
                            .padding(.horizontal, 80)
                            .padding(.top, 5)
                            .padding(.bottom, 20)
                            .foregroundStyle(Color("text"))
                            
                            VStack (spacing: 10){
                                HStack {
                                    Text("Workout statistics")
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Image(systemName: "chart.xyaxis.line")
                                        .foregroundStyle(Color.white)
                                }
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("darkpink"))
                                )
                                .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Water statistics")
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Image(systemName: "drop.halffull")
                                        .foregroundStyle(Color.white)
                                }
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("darkpink"))
                                )
                                .padding(.horizontal, 20)
                            }
                        }
                        .offset(y:40)
                        Spacer()
                        
                    } else {
                        Text("Loading profile...")
                            .font(.largeTitle)
                            .foregroundStyle(Color("darkpink"))
                            .opacity(0.5)
                    }
                    
                }
                .onAppear {
                    viewModel.fetchUser()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
