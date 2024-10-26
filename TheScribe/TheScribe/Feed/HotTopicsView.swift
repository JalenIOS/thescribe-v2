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
            
                
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(feedViewModel.currNews, id: \.url) { article in
                        
                        VStack{
                            if let urlString = article.urlToImage {
                                AsyncImage(url: URL(string: urlString)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(4 / 3, contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 320)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width, height: 320)

                                }
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                VStack(alignment: .leading) {
                                    Text(article.title)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Text("\(formatDate(dateStr: article.publishedAt)) By \(article.author ?? "")")
                                        .font(.footnote)
                                        .foregroundStyle(Color.gray)
                                    
                                }
                                
                                if let description = article.description {
                                    Text(description)
                                        .font(.subheadline)
                                        .lineLimit(3)
                                        .fixedSize(horizontal: false, vertical: true)
                                        
                                }
                                    
                            }
                            .padding()
                            
                            Spacer()
                            
                            HStack {
                                Image(systemName: "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8)
                                    .foregroundStyle(Color.gray)
                                
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 550, alignment: .top)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.label).opacity(0.15), lineWidth: 1)
                        )
                        
                            
                    }
                        
                    
                    
                }
                .padding()
                .scrollTargetLayout()
            }
//            .scrollTargetBehavior(.viewAligned)
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
