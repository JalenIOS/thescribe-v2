//
//  LocalNewsView.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import SwiftUI

struct LocalNewsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                Task {
                    let result = try await NewsManager.shared.getNews(reqType: .general)
                    print(result)

                }
            }
    }
}

#Preview {
    LocalNewsView()
}
