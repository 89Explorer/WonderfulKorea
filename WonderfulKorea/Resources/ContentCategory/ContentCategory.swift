//
//  ContentCategory.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/12/24.
//

import Foundation

// MARK: - Enum
enum ContentCategory: String {
    case attractions = "12"
    case facilities = "14"
    case course = "25"
    case restaurant = "38"
    
    var contentTypeId: String {
        return self.rawValue
    }
}
