//
//  ArtworkListViewModel.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import Foundation

class ArtworkListViewModel {
    func getArtworks(completion: @escaping ([Artwork]) -> ()) {
        //TODO: Replace
        DispatchQueue.global(qos: .background).async {
            sleep(3)

            let artworks = [
                Artwork(
                    id: "nl-SK-A-1505",
                    name: "Name 1",
                    imageURL: "https://lh3.googleusercontent.com/nfJiRConmXf4QR1bK3-E456qIEp2bYtuemyy3P3t7PonntyGJ8iPzFNKJPhZFCSSmJmj2AHePE4V1xl3BOz2NT8mfbNg=s0"
                ),
                Artwork(
                    id: "nl-SK-A-4688",
                    name: "Name 2",
                    imageURL: "https://lh3.googleusercontent.com/aqXgCqxvgXItt7Puc22OF8vbuuSGLiI8xUphPF3Jn_VWFBOcLwR96hBC4aRqAVxd_kGy6G-D2y8vRrTJOTbzcSMisc8=s0"
                ),
                Artwork(
                    id: "nl-SK-C-211",
                    name: "Name 3",
                    imageURL: "https://lh3.googleusercontent.com/3EDrQy1jW6akN2k8eAeCECHJ1FmvM1f2pb9a-de51ErcQcghh7cbpzFIh-QYdcGfpi3FjxH1AP6C_FvPNR-I9n8I4No=s0"
                )
            ]

            DispatchQueue.main.async {
                completion(artworks)
            }
        }
    }
}
