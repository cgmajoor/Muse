//
//  GetLandscapes.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

class GetLandscapes {
    private var webservice: ArtCollectionWebserviceProtocol
    
    init(webservice: ArtCollectionWebserviceProtocol = ArtCollectionWebservice()) {
        self.webservice = webservice
    }
    
    func execute(page: Int = 0, completion: @escaping ([Artwork]?, WebserviceError?) -> ()) {
        webservice.fetchCollection(type: "schilderij", searchTerm: "landschap", page: page, pageSize: 10) { artworks, error in
            guard let artworks = artworks else {
                completion(nil, error)
                return
            }
            
            let landscapes: [Artwork] = artworks.compactMap { artwork in
                return Artwork(id: artwork.id, name: artwork.name, imageURL: artwork.imageURL, type: .landscape)
            }
            
            completion(landscapes, nil)
        }
    }
}
