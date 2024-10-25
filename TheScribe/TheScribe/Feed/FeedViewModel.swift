//
//  FeedViewModel.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import Foundation

@Observable
final class FeedViewModel: @unchecked Sendable {
    var hotTopics: [Article] = []
    
    init() {
        Task {
            try await loadHotTopics()
        }
    }
    
    func loadHotTopics() async throws -> Void {
        let resp = try await NewsManager.shared.getNews(reqType: .topHeadlines)
        
        switch resp {
        case .success(let data):
            do {
                let newsData = try JSONDecoder().decode(NewsResponse.self, from: data)
                                
                self.hotTopics = newsData.articles
                    
            } catch {
                
            }
        case .failure(let error):
            print(error)
        }
            
    }
}
