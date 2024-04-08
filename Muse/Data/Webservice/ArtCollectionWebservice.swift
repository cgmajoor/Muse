//
//  ArtCollectionWebservice.swift
//  Muse
//
//  Created by Ceren Majoor on 04/04/2024.
//

import Foundation

struct ArtCollectionWebservice {
    // TODO: Refactor
    let baseURL = "https://www.rijksmuseum.nl/"
    let getCollectionPath = "api/nl/collection"
    let apiKey = "sI3IO2gJ"

    func fetchCollection(
        type: String = "schilderij",
        searchTerm: String = "portret",
        page: Int = 0,
        pageSize: Int = 20,
        completion: @escaping ([Artwork]?, WebserviceError?) -> ()
    ) {
        let endpoint = "\(baseURL)\(getCollectionPath)?key=\(apiKey)&p=\(page)&ps=\(pageSize)&imgonly=True&type=\(type)&q=\(searchTerm)"
        performRequest(endpoint: endpoint) { response, error in
            guard
                error == nil,
                let response = response
            else {
                completion(nil, error)
                return
            }

            completion(response.artObjects.map { $0.toDomainModel() }, nil)
        }
    }

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
}

private extension ArtCollectionWebservice {

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
