//
//  CountryFlagModel.swift
//  Excercise_Day3
//
//  Created by laptop MCO on 02/08/23.
//

import Foundation

struct CountryFlagModel: Decodable{
    let name: String
    let code: String
    let emoji: String
    let unicode: String
    let image: String
    
    enum CodingKeys: String, CodingKey{
        case name
        case code
        case emoji
        case unicode
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.code = try container.decode(String.self, forKey: .code)
        self.emoji = try container.decode(String.self, forKey: .emoji)
        self.unicode = try container.decode(String.self, forKey: .unicode)
        self.image = try container.decode(String.self, forKey: .image)
    }
}
