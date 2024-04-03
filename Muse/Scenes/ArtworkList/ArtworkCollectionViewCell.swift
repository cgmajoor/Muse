//
//  ArtworkCollectionViewCell.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    var dataTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        configureHierarchy()
        configureLayout()
    }

    func setup(with artwork: Artwork) {
        contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)

        downloadImage(artwork.imageURL) { [weak self] image in
            guard let self else { return }
            self.imageView.image = image
        }

        imageView.contentMode = .scaleAspectFit
        titleLabel.text = artwork.name
        titleLabel.textColor = .systemPink
    }

    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
        dataTask?.cancel()
    }
}

private extension ArtworkCollectionViewCell {

    func downloadImage(_ urlString: String, completion: @escaping (UIImage) -> ()) {
        //TODO: Refactor
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }

            if let url = URL(string: urlString) {
                self.dataTask = URLSession.shared.dataTask(with: url) { (data, response, err) in
                    guard let data = data else { return }

                    if err == nil {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        }
                    }
                }

                self.dataTask?.resume()
            }
        }
    }

    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }

    func configureLayout() {
        let padding: CGFloat = 10

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
