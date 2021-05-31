//
//  NewsChallengeRemoteDataManagerImp.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation
import RxSwift

final class RemoteNewsChallengeDataManagerImp: RemoteNewsChallengeDataManager {
    
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func fetchNews(filterNewsObject: FilterListNewsObject) -> (Observable<ArticlesList>) {
        let listMapper = ServerArticleListToArticlesList()
        
        return Observable.create { [weak self] observer in
            let request = ArticlesListRequest(filterNewsObject: filterNewsObject)
            self?.session.send(request: request) { result in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                        break
                    case .success(let data):
                        let response = listMapper.map(data)
                        observer.onNext(response)
                        break
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
