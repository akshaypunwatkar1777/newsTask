//
//  NewsViewModel.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchNews() {
        let url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cb997684783d462c9ada32fdc8e49357"
       // let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=cb997684783d462c9ada32fdc8e49357"
        guard let requestURL = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: requestURL)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.articles = response.articles
            })
            .store(in: &cancellables)
    }
}
