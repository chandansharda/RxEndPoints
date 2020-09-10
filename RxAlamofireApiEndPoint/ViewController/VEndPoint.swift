//
//  VEndPoint.swift
//  RxAlamofireApiEndPoint
//
//  Created by MAC on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation
import Alamofire

enum VEndPoint : ApiEndPoint {
    case login([String:Any])
    
    typealias Response = UserDataModle
    
    var endPoint: String {
        switch self {
        case .login:
            return "user/login"
        }
    }
    
    var parameters: Parameters? {
        get {
            switch self {
            case .login(let data):
                return data
            }
        }
    }
    
    var token: Bool {
        get {
            true
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
}


class UserDataModle: Codable {
    let expiresIn, token: String?

    init(expiresIn: String?, token: String?) {
        self.expiresIn = expiresIn
        self.token = token
    }
}
