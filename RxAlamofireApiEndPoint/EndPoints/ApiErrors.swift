//
//  ApiErrors.swift
//  RxAlamofireApiEndPoint
//
//  Created by Chandan Sharda on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation

enum ApiErrors: Error {
    case urlNotCorrect
    case noInstanceFound
    
    var localizedDescription: String {
        switch self {
        case .urlNotCorrect:
            return "Unable to create url endpoint."
            
        case .noInstanceFound:
            return "Instance Not Found."
        }
    }
}
