//
//  GetPortraits.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

class GetPortraits: GetArtworksProtocol {
    private var webservice: ArtCollectionWebserviceProtocol
    
    init(webservice: ArtCollectionWebserviceProtocol = ArtCollectionWebservice()) {
        self.webservice = webservice
    }
    
    func execute(page: Int = 0, completion: @escaping ([Artwork]?, WebserviceError?) -> ()) {
        webservice.fetchCollection(type: "schilderij", searchTerm: "portret", page: page, pageSize: AppConfig.pageSize) { artworks, error in
            guard let artworks = artworks else {
                completion(nil, error)
                return
            }
            
            let portraits: [Artwork] = artworks.compactMap { artwork in
                return Artwork(id: artwork.id, name: artwork.name, imageURL: artwork.imageURL, type: .portrait)
            }

            dump(portraits, name: "🍄 Portraits")
            completion(portraits, nil)
        }
    }
}
