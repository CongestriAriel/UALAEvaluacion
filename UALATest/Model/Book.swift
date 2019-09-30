//
//  Book.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import Foundation

struct Book: Decodable {
    var id: Int?
    var name: String?
    var author: String?
    var isAvailable: Bool?
    var popularityIndex: Int?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "id", name = "nombre", author = "autor", isAvailable = "disponibilidad", popularityIndex = "popularidad", imageURL = "imagen"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.author = try? container.decode(String.self, forKey: .author)
        self.isAvailable = try? container.decode(Bool.self, forKey: .isAvailable)
        self.popularityIndex = try? container.decode(Int.self, forKey: .popularityIndex)
        self.imageURL = try? container.decode(String.self, forKey: .imageURL)
    }
}
