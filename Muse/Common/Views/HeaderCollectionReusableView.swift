//
//  HeaderCollectionReusableView.swift
//  Muse
//
//  Created by Ceren Majoor on 03/04/2024.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    private var label = UILabel()

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

    func setup(with title: String) {
        backgroundColor = .systemPink
        label.textColor = .label
        label.text = title
    }

    func configureHierarchy() {
        addSubview(label)
    }

    func configureLayout() {
        let padding: CGFloat = 10
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
