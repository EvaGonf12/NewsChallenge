import Foundation
import RxSwift

protocol RemoteNewsChallengeDataManager {
    func fetchNews(filterNewsObject: FilterListNewsObject) -> (Observable<ArticlesList>)
}
