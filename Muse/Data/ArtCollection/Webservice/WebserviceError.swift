//
//  WebserviceError.swift
//  Muse
//
//  Created by Ceren Majoor on 08/04/2024.
//

import Foundation

enum WebserviceError: String {
    case genericError = "Something went wrong"
    case badResponse = "Bad response"
    case noData = "No data"
    case invalidData = "Could not parse data"
}
