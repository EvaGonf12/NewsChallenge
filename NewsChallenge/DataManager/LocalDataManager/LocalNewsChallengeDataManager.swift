import Foundation

protocol LocalNewsChallengeDataManager {
    func fetchNews(filterNewsObject: FilterListNewsObject) -> [CDArticle]
    func saveNews(_ articles: [Article])
    func savePageList(_ page: Int)
    func fetchPageList() -> Int
}
