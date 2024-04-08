//
//  ArtworkListRouter.swift
//  Muse
//
//  Created by Ceren Majoor on 09/04/2024.
//

import UIKit

protocol ArtworkListRouting {
    func didSelectArtwork(in viewController: ArtworkListViewController, artwork: Artwork)
}

class ArtworkListRouter: ArtworkListRouting {
    func didSelectArtwork(in viewController: ArtworkListViewController, artwork: Artwork) {
        let viewModel = ArtworkViewModel(artwork: artwork)
        let artworkViewController = ArtworkViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(artworkViewController, animated: true)
    }
}
