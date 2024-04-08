//
//  ArtCollectionWebservice.swift
//  Muse
//
//  Created by Ceren Majoor on 04/04/2024.
//

import Foundation

struct ArtCollectionWebservice: ArtCollectionWebserviceProtocol {
    // TODO: Refactor
    let baseURL = "https://www.rijksmuseum.nl/"
    let getCollectionPath = "api/nl/collection"

    func fetchCollection(
        type: String,
        searchTerm: String?,
        page: Int,
        pageSize: Int,
        completion: @escaping ([Artwork]?, WebserviceError?) -> ()
    ) {
        var filter: String = ""

        if let searchTerm = searchTerm {
            filter = "&q=\(searchTerm)"
        }

        let endpoint = "\(baseURL)\(getCollectionPath)?key=\(AppConfig.apiKey)&p=\(page)&ps=\(pageSize)&imgonly=True&type=\(type)\(filter)"

        performRequest(endpoint: endpoint) { response, error in
            guard
                error == nil,
                let response = response
            else {
                completion(nil, error)
                return
            }
            
            let artworks = response.artObjects.map { $0.toDomainModel() }
            completion(artworks, nil)
        }
    }
}

private extension ArtCollectionWebservice {

    func performRequest(endpoint: String, completion: @escaping (GetCollectionResponse?, WebserviceError?) -> ()) {
        if let urlRequest = URL(string: endpoint) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil, .genericError)
                }

                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    completion(nil, .badResponse)
                    return
                }

                guard let data = data else {
                    completion(nil, .noData)
                    return
                }

                parseJSON(data, completion: completion)
            }

            task.resume()
        }
    }

    func parseJSON(_ data: Data, completion: @escaping (GetCollectionResponse?, WebserviceError?) -> ()) {
        do {
            let decoder = JSONDecoder()
            let getCollectionResponse = try decoder.decode(GetCollectionResponse.self, from: data)
            completion(getCollectionResponse, nil)
        } catch {
            completion(nil, .invalidData)
        }
    }
}
