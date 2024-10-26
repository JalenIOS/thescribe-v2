//
//  FeedViewModel.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import Foundation

@Observable
final class FeedViewModel: @unchecked Sendable {
    var currNews: [Article] = []
    var newsViewTypes: [NewsDataSetType] = [
        .general,
        .business,
        .entertainment,
        .sports,
        .health,
        .science,
        .technology
    ]
    
    init() {
        Task {
            try await loadNews()
        }
    }
    
    func loadNews(newsDataType: NewsDataSetType = .general) async throws -> Void {
        let resp = try await NewsManager.shared.getNews(reqType: newsDataType)
        
        switch resp {
        case .success(let data):
            do {
                let newsData = try JSONDecoder().decode(NewsResponse.self, from: data)
                print(newsData)
                self.currNews = newsData.articles.filter( { !$0.title.lowercased().contains("[removed]") } )
                    
            } catch {
                print(error)
            }
        case .failure(let error):
            print(error)
        }
            
    }
}
