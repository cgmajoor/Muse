//
//  CanDownloadImage.swift
//  Muse
//
//  Created by Ceren Majoor on 09/04/2024.
//

import UIKit

protocol CanDownloadImage: NSObject {
    var dataTask: URLSessionDataTask? { get set }
}

extension CanDownloadImage {
    func downloadImage(_ urlString: String, completion: @escaping (UIImage) -> ()) {
        //TODO: Refactor
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            configureImageState(state: .loading, completion: completion)

            if let url = URL(string: urlString) {
                self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let self, let data = data else { return }

                    if error == nil {
                        if let image = UIImage(data: data) {
                            self.configureImageState(state: .success(image), completion: completion)
                        }
                    } else {
                        self.configureImageState(state: .error, completion: completion)
                    }
                }

                self.dataTask?.resume()
            }
        }
    }

    func configureImageState(state: ImageState, completion: @escaping (UIImage) -> ()) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                let loadingImage = UIImage(systemName: "photo.artframe")?.withTintColor(.tertiarySystemFill, renderingMode: .alwaysOriginal) ?? UIImage()
                completion(loadingImage)
            case .error:
                let errorImage = UIImage(systemName: "exclamationmark.square")?.withTintColor(.tertiarySystemFill, renderingMode: .alwaysOriginal) ?? UIImage()
                completion(errorImage)
            case .success(let image):
                completion(image)
            }
        }
    }
}
