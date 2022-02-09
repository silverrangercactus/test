//
//  NetworkModel.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 08.02.2022.
//

import Foundation

struct Cartoons: Decodable {
    
    let albumID: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id
        case title
        case url
        case thumbnailURL = "thumbnailUrl"
    }
}
