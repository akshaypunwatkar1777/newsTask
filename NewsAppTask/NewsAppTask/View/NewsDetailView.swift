//
//  NewsDetailView.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//

import SwiftUI
struct NewsDetailView: View {
    let article: Article
    @StateObject private var viewModel = NewsDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            AsyncImage(url: URL(string: article.urlToImage ?? "placeholder_url")) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(article.title).font(.title).bold()
            Text(article.description ?? "No Description Available").font(.body)
            Text("Likes: \(viewModel.likes)")
            Text("Comments: \(viewModel.comments)")
            Spacer()
        }
        .padding()
        .onAppear { viewModel.fetchAdditionalInfo(for: article) }
    }
}

