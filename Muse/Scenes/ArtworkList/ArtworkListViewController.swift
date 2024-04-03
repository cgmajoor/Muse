//
//  ArtworkListViewController.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import UIKit

class ArtworkListViewController: UIViewController {

    private var viewModel: ArtworkListViewModel

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true

        collectionView.register(
            ArtworkCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ArtworkCollectionViewCell.self)
        )
        collectionView.register(
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: HeaderCollectionReusableView.self)
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.sectionHeadersPinToVisibleBounds = true
        collectionViewFlowLayout.headerReferenceSize = .init(width: 100, height: 50)
        return collectionViewFlowLayout
    }()

    init(viewModel: ArtworkListViewModel = ArtworkListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Artworks"
        view.backgroundColor = .systemBackground

        setup()
        getArtworks()
    }
}

extension ArtworkListViewController: UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.artworks.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < viewModel.artworks.count else { return 0 }
        return viewModel.artworks[section].count
    }
}

extension ArtworkListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArtworkCollectionViewCell.self), for: indexPath) as? ArtworkCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.artworks[indexPath.section][indexPath.row]
        cell.setup(with: Artwork(id: item.id, name: item.name, imageURL: item.imageURL, type: item.type))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:  String(describing: HeaderCollectionReusableView.self),
                for: indexPath
            ) as? HeaderCollectionReusableView else {
                return UICollectionReusableView()
            }

        switch indexPath.section {
        case 0:
            view.setup(with: "Portrait")
        default:
            view.setup(with: "Landscape")
        }
        return view
    }
}

extension ArtworkListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
}

private extension ArtworkListViewController {

    func setup() {
        configureHierarchy()
        configureLayout()
    }

    func configureHierarchy() {
        view.addSubview(collectionView)
    }

    func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func getArtworks() {
        viewModel.getArtworks { [weak self] artworks in
            guard let self else { return }
            // TODO: Replace
            self.collectionView.reloadData()
        }
    }
}
