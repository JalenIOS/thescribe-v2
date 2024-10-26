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
    
    func getNews(reqType: NewsDataSetType) async throws -> Result<Data, NewsManagerError> {
        guard let url = URL(string: "\(baseUrl)\(reqType.urlString)") else { return .failure(.invalidRequest(URLError(.badURL))) }
        
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

enum NewsDataSetType {
    case general
    case entertainment
    case sports
    case health
    case science
    case technology
    case business
    
    var urlString: String {
        let baseURL = "/v2/top-headlines?category="
        let country = "&country=us"
        
        switch self {
        case .general:
            return baseURL + "general" + country
        case .entertainment:
            return baseURL + "entertainment" + country
        case .sports:
            return baseURL + "sports" + country
        case .health:
            return baseURL + "health" + country
        case .science:
            return baseURL + "science" + country
        case .technology:
            return baseURL + "technology" + country
        case .business:
            return baseURL + "business" + country
        }
    }
    
    var label: String {
        
        switch self {
        case .general:
            return "General"
        case .entertainment:
            return "Entertainment"
        case .sports:
            return "Sports"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .technology:
            return "Technology"
        case .business:
            return "Business"
        }
    }
}


enum NewsManagerError: Error {
    case invalidRequest(Error)
    case invalidData(Error)
}
