import Foundation

struct CartMeta: Codable {
    var products: [Cart]
}

struct Cart: Codable, Identifiable {
    var id: Int
    var title: String
    var price: Int
    var quantity: Int
    var total: Int
    var discountPercentage: Double
    var discountedPrice: Int
}

func getCart(urlString: String) async throws -> [Cart] {
    let url = URL(string: urlString)!
    let urlrequest = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: urlrequest)
    let cart = try JSONDecoder().decode(CartMeta.self, from: data)
    return cart.products
}
