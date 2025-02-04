//
//  NewsAppTests.swift
//  NewsAppTask
//
//  Created by Akshay Punwatkar on 05/02/25.
//


import XCTest
@testable import NewsAppTask

class NewsAppTests: XCTestCase {
    func testArticleParsing() {
        let jsonData = """
        {
            "title": "Sample News",
            "description": "This is a test description",
            "author": "Test Author",
            "url": "https://test.com",
            "urlToImage": "https://test.com/image.jpg"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let article = try? decoder.decode(Article.self, from: jsonData)
        
        XCTAssertNotNil(article)
        XCTAssertEqual(article?.title, "Sample News")
        XCTAssertEqual(article?.author, "Test Author")
    }
    
    func testArticleIDConversion() {
        let articleURL = "https://www.theverge.com/2020/7/21/21332300/nikon-z5-full-frame-mirrorless-camera-price-release-date-specs/index.html"
        let articleID = articleURL.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "/", with: "-")
        XCTAssertEqual(articleID, "www.theverge.com-2020-7-21-21332300-nikon-z5-full-frame-mirrorless-camera-price-release-date-specs-index.html")
    }
}
