//
//  ArtCollectionWebserviceProtocol.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

protocol ArtCollectionWebserviceProtocol {
    func fetchCollection(type: String, searchTerm: String, page: Int, pageSize: Int, completion: @escaping ([Artwork]?, WebserviceError?) -> ())
}
