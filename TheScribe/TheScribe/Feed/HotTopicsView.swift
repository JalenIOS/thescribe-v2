//
//  HotTopicsView.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import SwiftUI

struct HotTopicsView: View {
    @Environment(FeedViewModel.self) private var feedViewModel: FeedViewModel
    
    private func formatDate(dateStr: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        if let date = isoFormatter.date(from: dateStr) {
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("HOT TOPICS 🔥")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray)
                
                Spacer()
                
                Text("See all")
                    .font(.footnote)
                    .foregroundStyle(Color.pink)
                    .padding(.trailing)
                
            }
            .padding([.top,.horizontal], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
                
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(feedViewModel.hotTopics, id: \.url) { article in
                        
                        VStack{
                            if let urlString = article.urlToImage {
                                AsyncImage(url: URL(string: urlString)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(4 / 3, contentMode: .fill)
                                        .frame(width: 330, height: 320)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                                
                            }
                            
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.body)
                                    .fontWeight(.bold)
                                Text("\(formatDate(dateStr: article.publishedAt)) By \(article.author ?? "")")
                                    .font(.footnote)
                                    .foregroundStyle(Color.gray)
                                
                                Text(article.description)
                                    .font(.subheadline)
                                    
                            }
                            
                        }
                        .frame(width: 330, height: 500, alignment: .top)
                        
                            
                    }
                        
                    
                    
                }
                .padding()
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            
        }
    }
}

//#Preview {
//    HotTopicsView()
//}
