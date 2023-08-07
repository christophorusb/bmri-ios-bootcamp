//
//  File.swift
//  Concurrency_Ditto
//
//  Created by laptop MCO on 07/08/23.
//

import Foundation

struct Waifu: Identifiable, Decodable {
    var id = UUID() 
    let name: String
    let anime: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case anime
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.anime = try container.decode(String.self, forKey: .anime)
        self.image = try container.decode(String.self, forKey: .image)
        self.id = UUID()
    }
}

