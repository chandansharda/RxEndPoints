//
//  ContentType.swift
//  RxAlamofireApiEndPoint
//
//  Created by MAC on 31/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation


enum ContentType {
    case applicationJson
    
    var getDescription: [String: String] {
        switch self {
        case .applicationJson:
            return ["Accept": "application/json"]
        }
    }
}
