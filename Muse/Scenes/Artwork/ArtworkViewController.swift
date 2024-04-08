//
//  ArtworkViewController.swift
//  Muse
//
//  Created by Ceren Majoor on 09/04/2024.
//

import UIKit

class ArtworkViewController: UIViewController, CanDownloadImage {
    var dataTask: URLSessionDataTask?

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    let viewModel: ArtworkViewModel

    init(viewModel: ArtworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension ArtworkViewController {

    func setup() {
        title = "Artwork Detail"
        view.backgroundColor = .systemBackground

        downloadImage(viewModel.artwork.imageURL) { [weak self] image in
            guard let self else { return }
            self.imageView.image = image
        }
        imageView.contentMode = .scaleAspectFit

        titleLabel.textColor = .label
        titleLabel.text = viewModel.artwork.name

        configureHierarchy()
        configureLayout()
    }

    func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
    }

    func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
