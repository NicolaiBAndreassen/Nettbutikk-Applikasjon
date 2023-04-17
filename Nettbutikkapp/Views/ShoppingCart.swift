import SwiftUI

struct ShoppingCart: View {
    @State private var carts: [Cart] = []
    @State public var user: User

    
    var body: some View {
        NavigationStack {
            List(carts) { cart in
                    VStack {
                        Text(cart.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.all, 1)
                        Text("kr " + String(cart.price))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.all, 1)
                        Text(String(cart.quantity) + " Left")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.all, 1)
                            .foregroundColor(.gray)
                    }
                }
            .navigationTitle("Shopping Cart")
        }
        
        .task {
            do {
                carts = try await getCart(urlString: "https://dummyjson.com/carts/\(user.id)")
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .refreshable {
            do {
                carts = try await getCart(urlString: "https://dummyjson.com/carts/\(user.id)")
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

struct ShoppingCart_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCart(user: User(id: 1, firstName: "First name", lastName: "Last name", age: 0, email: "String", phone: "4011234", username: "username", password: "password", birthDate: "0000-00-00", image: "https://robohash.org/hicveldicta.png"))
    }
}
