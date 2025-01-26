//
//  ErrorMapperUtils.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

class ErrorMapperUtils {
    
    static let shared = ErrorMapperUtils()
    
    func mappError(_ rawError: String) -> String?{
        var error: String? = nil
        
        if rawError.contains("Internet connection appears to be offline") || rawError.contains("timed out") || rawError.contains("data connection") {
            //error = "Kindly check your internet connection and try again."
            error = nil
        }
        else if rawError.contains("Decoding")
                    ||  rawError.contains("400") {
            error = "Something went wrong, please try again."
        }
        else if rawError.contains("Connection refused") || rawError.contains("JSON") || rawError.contains("Our systems"){
            error = "Our systems are currently down. Please try again later."
        }
        else if rawError.contains("locked"){
            error = "Oh dear Your account has been locked ."
        }
        else if rawError.contains("temporarily unavailable"){
            error = "We were unable to complete your request at this time. Please try again later."
        }
        else if rawError.contains("RCE0911") || rawError.contains("RCE1201"){
            error = "We were unable to complete your request at this time. Please try again later."
        }
        else if rawError.contains("Invalid User") {
            error = "Invalid User ID / Password."
        }
        else {
            error = "Something went wrong, please try again."
        }
        return error
    }
}
