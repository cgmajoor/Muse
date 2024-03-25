//
//  ArtworkListViewController.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import UIKit

class ArtworkListViewController: UIViewController {

    private var viewModel: ArtworkListViewModel

    init(viewModel: ArtworkListViewModel = ArtworkListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Artworks"
        view.backgroundColor = .systemBackground

        getArtworks()
    }
}


private extension ArtworkListViewController {

    func getArtworks() {
        viewModel.getArtworks { artworks in
            // TODO: Replace
            dump(artworks, name: "LOG: got Artworks")
        }
    }
}
