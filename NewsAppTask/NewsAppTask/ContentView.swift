//
//  ContentView.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                NavigationLink(destination: NewsDetailView(article: article)) {
                    HStack {
                        AsyncImage(url: URL(string: article.urlToImage ?? "placeholder_url")) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "photo")
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text(article.title).bold()
                            Text(article.author ?? "Unknown Author").font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
            }
            .onAppear { viewModel.fetchNews() }
            .navigationTitle("US News")
        }
    }
}
#Preview {
    ContentView()
}
