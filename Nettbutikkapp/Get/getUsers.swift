import Foundation

struct UserMeta: Codable {
    var users: [User]
}

struct User: Codable, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    var age: Int
    var email: String
    var phone: String
    var username: String
    var password: String
    var birthDate: String
    var image: String
}

func getUser(urlString: String) async throws -> [User] {
    let url = URL(string: urlString)!
    let urlrequest = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: urlrequest)
    let user = try JSONDecoder().decode(UserMeta.self, from: data)
    return user.users
}

