//
//  ContentView.swift
//  TheScribe
//
//  Created by Jalen Arms on 10/25/24.
//

import SwiftUI

struct TheScribeContentView: View {
    @State private var currTabView: TabViewType = .feed
    
    var body: some View {
        VStack {
            currTabView.view()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .top) {
            HStack {
                Text("The Scribe")
                    .font(.title)
                    .fontWeight(.semibold)
                
                
                Image(systemName: "applescript")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.thickMaterial)
            .foregroundStyle(Color(.pink))
            .compositingGroup()
            .shadow(color: Color(.label).opacity(0.35), radius: 1)
            
        }
        .safeAreaInset(edge: .bottom) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                VStack(spacing: 10) {

                    Image(systemName: "newspaper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(Color(.pink))
                }
                
                VStack(spacing: 10) {
//                    Rectangle()
//                        .frame(height: 1)
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(Color.gray)
                }
                
                VStack(spacing: 10) {
//                    Rectangle()
//                        .frame(height: 1)
                    Image(systemName: "text.bubble")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(Color.gray)
                }
                
                VStack(spacing: 10) {
//                    Rectangle()
//                        .frame(height: 1)
                    Image(systemName: "person.crop.circle.badge.questionmark.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(30)
//            .background(.ultraThickMaterial)
        }
    }
}

enum TabViewType {
    case feed
    case favorites
    case chat
    case profile
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .feed:
            FeedView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    TheScribeContentView().preferredColorScheme(.dark)
    
}
