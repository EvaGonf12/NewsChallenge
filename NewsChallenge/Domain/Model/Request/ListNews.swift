//
//  ArticlesListRequest.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

struct FilterListNewsObject {
    var pageSize: String
    var page: String
    
    init(pageSize: String,
         page: String) {
        
        self.pageSize = pageSize
        self.page = page
    }
}

struct ArticlesListRequest: APIRequest {
    
    typealias Response = ServerArticleList
    
    var topic: String = "covid"
    var pageSize: String
    var page: String
    
    init(filterNewsObject: FilterListNewsObject) {
        self.pageSize = "\(filterNewsObject.pageSize)"
        self.page = "\(filterNewsObject.page)"
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/v2/everything"
    }
    
    var parameters: [String : String] {
        return ["q": topic,
                "pageSize": pageSize,
                "page": page,
                "language": "es",
                "sortBy": "publishedAt"]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
