import Foundation

struct ProductMeta: Codable {
    var products: [Product]
}

struct Product: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var thumbnail: String
    var brand: String
    var category: String
}

func getProduct(urlString: String) async throws -> [Product] {
    let url = URL(string: urlString)!
    let urlrequest = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: urlrequest)
    let product = try JSONDecoder().decode(ProductMeta.self, from: data)
    return product.products
}
