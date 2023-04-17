import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State public var user: User
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(products) { product in
                        NavigationLink(destination: ProductView(product: product)) {
                            VStack {
                                AsyncImage(url: URL(string: product.thumbnail), scale: 3)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .padding()
                                HStack {
                                    VStack(alignment: .center) {
                                        Text(product.title)
                                            .font(.headline)
                                    }
                                }
                                .padding()
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            
            HStack {
                NavigationLink(destination: ShoppingCart(user: user)) {
                    Image(systemName: "cart")
                    }
                    .imageScale(.large)
                    .frame(maxWidth: .infinity)
                    .navigationBarBackButtonHidden()
                
                NavigationLink(destination: UserInformation(user: user)) {
                    Image(systemName: "person")
                }
                .imageScale(.large)
                .frame(maxWidth: .infinity)
                .navigationBarBackButtonHidden()
            }
            .foregroundColor(.black)
        }
        
        .task {
            do {
                products = try await getProduct(urlString: "https://dummyjson.com/products")
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .refreshable {
            do {
                products = try await getProduct(urlString: "https://dummyjson.com/products")
                print(products)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ProductView: View {
    
    var product: Product
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.thumbnail))
            Text(product.brand)
            Text(product.title)
                .font(.title)
                .padding(.bottom, 5)
            Text(product.description)
            Text("kr " + String(product.price))
                .padding(.all)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User(id: 1, firstName: "First name", lastName: "Last name", age: 0, email: "String", phone: "4011234", username: "username", password: "password", birthDate: "0000-00-00", image: "https://robohash.org/hicveldicta.png"))
    }
}

