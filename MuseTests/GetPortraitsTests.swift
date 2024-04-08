//
//  GetPortraitsTests.swift
//  MuseTests
//
//  Created by Ceren Majoor on 08/04/2024.
//

import XCTest
@testable import Muse

final class GetPortraitsTests: XCTestCase {
    let mockWebservice: MockArtCollectionWebservice = MockArtCollectionWebservice()
    var sut: GetPortraits!

    override func setUp() {
        sut = GetPortraits(webservice: mockWebservice)
    }

    func test_invokesFetchCollection_When_CallingExecute() throws {
        XCTAssertFalse(mockWebservice.invokedFetchCollection)
        let expectations = XCTestExpectation(description: "expected to invoke webservice")
        sut.execute { artworks, error in
            expectations.fulfill()
        }
        XCTAssertTrue(mockWebservice.invokedFetchCollection)
    }

    func test_returnsCorrectResponse_When_CallingExecute_Whilst_WebserviceSucceeds() throws {
        mockWebservice.stubbedResponse = [Artwork(id: "nl-1", name: "Night Watch", imageURL: "http://abc.com", type: .portrait)]
        let expectations = XCTestExpectation(description: "expected 1 artwork")
        var result: [Artwork] = []
        sut.execute { artworks, error in
            guard let artworks = artworks else {
                expectations.fulfill()
                return
            }
            result = artworks
            expectations.fulfill()
        }
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Night Watch")
    }

    func test_returnsCorrectResponse_When_CallingExecute_Whilst_WebserviceSucceedsWith2Artworks() throws {
        mockWebservice.stubbedResponse = [
            Artwork(id: "nl-1", name: "Art 1", imageURL: "http://aaa.com", type: .portrait),
            Artwork(id: "nl-2", name: "Art 2", imageURL: "http://bbb.com", type: .landscape)
        ]
        let expectations = XCTestExpectation(description: "expected 1 artwork")
        var result: [Artwork] = []
        sut.execute { artworks, error in
            guard let artworks = artworks else {
                expectations.fulfill()
                return
            }
            result = artworks
            expectations.fulfill()
        }
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].name, "Art 1")
        XCTAssertEqual(result[1].name, "Art 2")
    }

    func test_returnsError_When_CallingExecute_Whilst_WebserviceFails() throws {
        mockWebservice.stubbedResponse = nil
        mockWebservice.stubbedError = .genericError
        let expectations = XCTestExpectation(description: "expected generic error")

        var resultError: WebserviceError?
        sut.execute { artworks, error in
            guard let error = error else {
                expectations.fulfill()
                return
            }
            
            resultError = error
            expectations.fulfill()
        }

        XCTAssertEqual(resultError, .genericError)
    }
}
