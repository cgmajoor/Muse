//
//  GetArtworksProtocol.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

protocol GetArtworksProtocol {
    func execute(page: Int, completion: @escaping ([Artwork]?, WebserviceError?) -> ())
}
