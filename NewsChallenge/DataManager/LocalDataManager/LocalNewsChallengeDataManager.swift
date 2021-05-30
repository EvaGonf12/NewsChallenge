import Foundation

protocol LocalNewsChallengeDataManager {
    /// Fetch Local Articles
    func fetchNews() -> [CDArticle]
    
    /// Fetch Filtered Local Articles
    func filterNews(with filter: String) -> [CDArticle]
    
    /// Save Articles in Local Data Base
    func saveNews(_ articles: [Article])
    
    /// Clear articles from Local Data Base
    func clearList()
    
    /// Save current page
    func savePageList(_ page: Int)
    
    /// Fetch current page
    func fetchPageList() -> Int
}
