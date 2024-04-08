//
//  MockArtCollectionWebservice.swift
//  MuseTests
//
//  Created by Ceren Majoor on 08/04/2024.
//

@testable import Muse
import Foundation

class MockArtCollectionWebservice: ArtCollectionWebserviceProtocol {

    public var invokedFetchCollection = false
    public var stubbedResponse: [Artwork]?
    public var stubbedError: WebserviceError?

    func fetchCollection(
        type: String,
        searchTerm: String?,
        page: Int,
        pageSize: Int,
        completion: @escaping ([Artwork]?, WebserviceError?) -> ()
    ) {
        self.invokedFetchCollection = true
        completion(stubbedResponse, stubbedError)
    }
}
