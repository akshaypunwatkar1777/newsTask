//
//  NewsDetailViewModel.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//
import SwiftUI
import Combine

class NewsDetailViewModel: ObservableObject {
    @Published var likes: Int = 0
    @Published var comments: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAdditionalInfo(for article: Article) {

        let articleID = article.url
                .replacingOccurrences(of: "https://", with: "")
                .replacingOccurrences(of: "http://", with: "")
                .replacingOccurrences(of: "/", with: "-")
        
        let likesURL = URL(string: "https://cn-news-info-api.herokuapp.com/likes/\(articleID)")!
        let commentsURL = URL(string: "https://cn-news-info-api.herokuapp.com/comments/\(articleID)")!
        
        // Fetch likes
               URLSession.shared.dataTaskPublisher(for: likesURL)
                   .map { $0.data }
                   .decode(type: NewsInteraction.self, decoder: JSONDecoder())
                   .receive(on: DispatchQueue.main)
                   .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] interaction in
                       self?.likes = interaction.count
                   })
                   .store(in: &cancellables)
               
               // Fetch comments
               URLSession.shared.dataTaskPublisher(for: commentsURL)
                   .map { $0.data }
                   .decode(type: NewsInteraction.self, decoder: JSONDecoder())
                   .receive(on: DispatchQueue.main)
                   .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] interaction in
                       self?.comments = interaction.count
                   })
                   .store(in: &cancellables)
    }
}

