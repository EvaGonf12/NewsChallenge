
import Foundation

struct ServerArticleList: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ServerArticle]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
