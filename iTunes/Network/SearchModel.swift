//
//  SearchModel.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import Foundation

struct Itunes: Decodable {
    let results: [Music]
}

struct Music: Decodable {
    let image, name: String
    enum CodingKeys: String, CodingKey {
        case image = "artworkUrl60"
        case name = "collectionName"
    }
}
