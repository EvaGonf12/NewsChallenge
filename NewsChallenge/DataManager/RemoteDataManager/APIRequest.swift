//
//  APIRequest.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum HeaderType: String {
    case contentType = "Content-Type"
    case apiKey = "X-Api-Key"
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}

extension APIRequest {
    
    var baseURL: URL {
        guard let baseURL = URL(string: Environment.baseUrl) else {
            fatalError("URL not valid")
        }
        return baseURL
    }
    
    var apiKey: String {
        return Environment.apiKey
    }
    
    var contentType: String {
        return Environment.contentType
    }
    
    func requestWithBaseUrl() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let finalUrl = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalUrl)
        
        request.httpMethod = method.rawValue
        
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .sortedKeys)
            request.httpBody = jsonData
        }

        request.addValue(contentType, forHTTPHeaderField: HeaderType.contentType.rawValue)
        request.addValue(apiKey, forHTTPHeaderField: HeaderType.apiKey.rawValue)
        return request
    }
}
