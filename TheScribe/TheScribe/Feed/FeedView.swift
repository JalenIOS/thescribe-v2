//
//  FeedView.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import SwiftUI

struct FeedView: View {
    @State var feedViewModel: FeedViewModel = FeedViewModel()
    @State var currNewsType: NewsDataSetType = .general
    @Namespace private var testId
    @Namespace private var tabBar
    
    var body: some View {
        VStack(spacing: 5) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(feedViewModel.newsViewTypes, id: \.self) { t in
                        ZStack(alignment: .bottom) {
                            VStack {
                                Text(t.label)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(t == currNewsType ? .pink : .gray)
                                    .onTapGesture {
                                        if t != currNewsType {
                                            withAnimation {
                                                currNewsType = t
                                                
                                            }
                                            
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            if t == currNewsType {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.pink)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: tabBar, in: testId)
                                
                            }
                        }
                    }
                    
                }
                .padding([.vertical,.horizontal], 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .scrollIndicators(.hidden)
            
            HotTopicsView()
        }
        .onChange(of: currNewsType) { _, _ in
            Task {
               try await feedViewModel.loadNews(newsDataType: currNewsType)
                
            }
        }
        .environment(feedViewModel)
    }
}

//#Preview {
//    FeedView()
//}
