//
//  ArtworkListViewModel.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import Foundation

class ArtworkListViewModel {

    var artworks: [[Artwork]] = [[],[]]
    
    var getPortraits: GetPortraits
    var getLandscapes: GetLandscapes

    init(
        getPortraits: GetPortraits = GetPortraits(),
        getLandscapes: GetLandscapes = GetLandscapes()
    ) {
        self.getPortraits = getPortraits
        self.getLandscapes = getLandscapes
    }

    func getArtworks(completion: @escaping ([[Artwork]]) -> ()) {
        getPortraits.execute { [weak self] portraits, error in
            guard  let self else { return }

            guard let portraits = portraits else {
                // TODO: Empty portraits
                return
            }

            self.appendIfHasNewItem(type: .portrait, artworks: portraits)

            self.getLandscapes.execute { landscapes, error in
                guard let landscapes = landscapes else {
                    // TODO: Empty landscapes
                    return
                }

                self.appendIfHasNewItem(type: .landscape, artworks: landscapes)
                completion(self.artworks)
            }
        }
    }

    private func appendIfHasNewItem(type: ArtworkType, artworks: [Artwork]) {
        switch type {
        case .portrait:
            if artworks.count > self.artworks[0].count {
                self.artworks[0].append(contentsOf: artworks)
            }
        case .landscape:
            if artworks.count > self.artworks[1].count {
                self.artworks[1].append(contentsOf: artworks)
            }
        }
    }
}
