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
    private var page = 0
    private var getPortraits: GetArtworksProtocol
    private var getLandscapes: GetArtworksProtocol
    
    init(
        getPortraits: GetArtworksProtocol = GetPortraits(),
        getLandscapes: GetArtworksProtocol = GetLandscapes()
    ) {
        self.getPortraits = getPortraits
        self.getLandscapes = getLandscapes
    }
    
    func getArtworks(completion: @escaping ([[Artwork]], WebserviceError?) -> ()) {
        // TODO: Refactor
        guard (page * AppConfig.pageSize) < 10000 else {
            completion(self.artworks, nil)
            return
        }
        
        getPortraits.execute(page: page) { [weak self] portraits, portraitsError in
            guard  let self else { return }
            if let portraitsError = portraitsError {
                completion([[],[]], portraitsError)
            }
            
            guard let portraits = portraits else {
                return
            }
            
            self.artworks[0].append(contentsOf: portraits)
            
            self.getLandscapes.execute(page: page) { landscapes, landscapesError in
                if let landscapesError = landscapesError {
                    completion([[],[]], landscapesError)
                }
                
                guard let landscapes = landscapes else {
                    return
                }
                
                self.artworks[1].append(contentsOf: landscapes)
                
                self.page += 1
                self.isLoading = false
                print("Fetched page \(self.page)")
                
                completion(self.artworks, nil)
            }
        }
    }
}
