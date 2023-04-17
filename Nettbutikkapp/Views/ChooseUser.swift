import SwiftUI

struct ChooseUser: View {
    @State private var users: [User] = []

    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(destination: ContentView(user: user)) {
                    Text(user.firstName)
                }
            }
            .navigationTitle("Users")
        }
        
        .task {
            do {
                users = try await getUser(urlString: "https://dummyjson.com/user")
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .refreshable {
            do {
                users = try await getUser(urlString: "https://dummyjson.com/user")
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ChooseUser_Previews: PreviewProvider {
    static var previews: some View {
        ChooseUser()
    }
}
