//
//  Article.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//
import SwiftUI
import Combine

struct Article: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, author, url, urlToImage
    }
}

struct NewsResponse: Codable {
    let articles: [Article]
}

struct NewsInteractionResponse: Codable {
    let status: String
    let data: NewsInteraction
}

struct NewsInteraction: Codable {
    let count: Int
}

