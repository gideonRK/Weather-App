//
//  FetchState.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

enum FetchState: Comparable{
    case good
    case isLoading
    case noResults
    case error(String)
}
