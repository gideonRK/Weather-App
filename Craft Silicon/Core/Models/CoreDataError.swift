//
//  CoreDataError.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 26/01/2025.
//

import Foundation

enum CoreDataError: Error, CustomStringConvertible {
    case dataNotFound
    case fileNotFound(String)
    case dataCorrupted
    case dataProcessingFailed
    case dataValidationFailed
    case parsingError(Error?)
    case encodingError(Error?)
    case custom(String)
    case unknown
    
    var description: String {
        switch self {
        case .dataNotFound:
            return "Data not found"
        case .dataCorrupted:
            return "Data corrupted or Invalid"
        case .dataProcessingFailed:
            return "Data processing failed"
        case .dataValidationFailed:
            return "Data validation failed"
        case .custom(let error):
            return error
        case .unknown:
            return "Unknwon error occurred"
        case .fileNotFound(let path):
            return "file not found at path: \(path)"
        case .parsingError(let error):
            return "error parsing data: \(error?.localizedDescription ?? "unknown error")"
        case .encodingError(let error):
            return "error encoding data: \(error?.localizedDescription ?? "unknown error")"
        }
    }
}
