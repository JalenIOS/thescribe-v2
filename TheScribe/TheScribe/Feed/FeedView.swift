//
//  FeedView.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import SwiftUI

struct FeedView: View {
    @State var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            HotTopicsView()
        }
        .environment(feedViewModel)
    }
}

//#Preview {
//    FeedView()
//}
