//
//  BooksData.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import Foundation

struct BooksData: Decodable {
    let books: [Books]
    
    private enum CodingKeys: String, CodingKey {
        case books = "results"
    }
}

struct Books: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Items]
    
    private enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case totalItems = "totalItems"
        case items = "items"
    }
}

struct Items: Decodable {
    let kind: String
    let id: String
    let volumeInfo: VolumeInfo
}
struct VolumeInfo: Decodable {
    let title: String?
    let description: String?
    let imageLinks: ImageLinks
}

struct ImageLinks: Decodable {
    let thumbnail: String?
}
