import SwiftUI

struct UserInformation: View {
    @State private var users: [User] = []
    
    var user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(user.username)
                    .font(.largeTitle)
                    .frame(width: 300)
                    .padding(.bottom, 50)
            }
            VStack {
                VStack {
                    AsyncImage(url: URL(string: user.image))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 160)
                        .padding(.bottom, 50)
                }
            
                HStack {
                    Text(user.firstName)
                    Text(user.lastName)
                }
                .frame(width: 300)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(.white)
                
                VStack {
                    Text(user.birthDate)
                }
                .padding(.bottom, 5)
                
                VStack {
                    HStack {
                        Text("Email")
                            .bold()
                        Text(user.email)
                    }
                    HStack {
                        Text("Phone Number")
                            .bold()
                        Text(String(user.phone))
                    }
                }
            .navigationTitle("PERSONAL INFORMATION")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.black)
        }
    }
}

struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation(user: User(id: 1, firstName: "First name", lastName: "Last name", age: 0, email: "String", phone: "4011234", username: "username", password: "password", birthDate: "0000-00-00", image: "https://robohash.org/hicveldicta.png"))
    }
}
