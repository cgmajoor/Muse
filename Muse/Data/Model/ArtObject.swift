//
//  ArtObject.swift
//  Muse
//
//  Created by Ceren Majoor on 04/04/2024.
//

import Foundation

struct ArtObject: Decodable {
    let id: String
    let objectNumber: String
    let title: String
    let webImage: WebImage
}

extension ArtObject {

    func toDomainModel() -> Artwork {
        return Artwork(id: self.id, name: self.title, imageURL: self.webImage.url, type: nil)
    }
}
