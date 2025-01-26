//
//  APIError.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

enum APIError: Error, CustomStringConvertible{
    case badURL
    case urlSession(Error)
    case badResponse(Int)
    case decoding(DecodingError)
    case custom(String)
    case smthWentWrong
    case unkown
    case unexpected
    
    var description: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .urlSession(let error):
            return "\(error.localizedDescription)"
        case .badResponse(let statusCode):
            return "Bad response with status code \(statusCode)"
        case .decoding(let decodingError):
            return "Decoding error \(decodingError.localizedDescription)"
        case .custom(let error):
            return error
        case .smthWentWrong:
            return "Oops! Something went wrong, kindly try again."
        case .unkown:
            return "Unknown error."
        case .unexpected:
            return "Unexpected error occurred, kindly try again."
        }
    }
}
