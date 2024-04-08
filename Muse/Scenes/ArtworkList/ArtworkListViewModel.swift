//
//  ArtworkListViewModel.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import Foundation

class ArtworkListViewModel {

    var artworks: [[Artwork]] = [[],[]]
    
    private var isLoading: Bool = false
    private var page = 1
    private var getPortraits: GetArtworksProtocol
    private var getLandscapes: GetArtworksProtocol

    init(
        getPortraits: GetArtworksProtocol = GetPortraits(),
        getLandscapes: GetArtworksProtocol = GetLandscapes()
    ) {
        self.getPortraits = getPortraits
        self.getLandscapes = getLandscapes
    }

    func getArtworks(completion: @escaping ([[Artwork]]) -> ()) {
        getPortraits.execute(page: page) { [weak self] portraits, error in
            guard  let self else { return }

            guard let portraits = portraits else {
                // TODO: Empty portraits
                return
            }

            self.artworks[0].append(contentsOf: portraits)

            self.getLandscapes.execute(page: page) { landscapes, error in
                guard let landscapes = landscapes else {
                    // TODO: Empty landscapes
                    return
                }

                self.artworks[1].append(contentsOf: landscapes)

                self.page += 1
                self.isLoading = false
                print("Fetched page \(self.page)")
                
                completion(self.artworks)
            }
        }
    }
}
