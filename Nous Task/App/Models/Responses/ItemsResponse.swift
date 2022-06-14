//
//  ItemsResponse.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation

class Welcome: BaseResponse {
    var items: [Item] = []
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Item].self, forKey: .items) ?? []
        super.init()
    }
}

// MARK: - Item
class Item: Codable {
    var id: Int
    var title, itemDescription: String
    var imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case itemDescription = "description"
        case imageURL = "imageUrl"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        itemDescription = try values.decodeIfPresent(String.self, forKey: .itemDescription) ?? ""
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
    }
    
    init(id: Int, title: String, itemDescription: String, imageURL: String) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.imageURL = imageURL
    }
}
