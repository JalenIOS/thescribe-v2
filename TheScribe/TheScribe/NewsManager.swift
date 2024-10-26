//
//  NewsManager.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import Foundation

final class NewsManager: Sendable {
    static let shared = NewsManager()
    let baseUrl = "https://newsapi.org"
    var configKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "NEWS_KEY") as? String ?? ""
    }
    
    init() {
        
    }
    
    func getNews(reqType: NewsReqType) async throws -> Result<Data, NewsManagerError> {
        print("\(baseUrl)?country=us")
        guard let url = URL(string: "\(baseUrl)\(reqType.rawValue)?country=us") else { return .failure(.invalidRequest(URLError(.badURL))) }
        
        var req = URLRequest(url: url)
        
        req.addValue(configKey, forHTTPHeaderField: "X-Api-Key")
        
        do  {
            let (data, response) = try await URLSession.shared.data(for: req)
            let str = String(data:data, encoding: .utf8)
//            print(str!)
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return .failure(.invalidRequest(URLError(.badServerResponse)))
            }
            
            return .success(data)
            
            
        } catch {
            print(error)
            return .failure(.invalidRequest(error))
        }
        
    }
    
}

enum NewsReqType: String {
    case topHeadlines = "/v2/top-headlines"
    case allNews = "/v2/everything"
}

enum NewsManagerError: Error {
    case invalidRequest(Error)
    case invalidData(Error)
}
