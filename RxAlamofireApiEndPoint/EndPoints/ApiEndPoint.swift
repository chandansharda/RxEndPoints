//
//  ApiEndPoint.swift
//  RxAlamofireApiEndPoint
//
//  Created by Chandan Sharda on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation
import Alamofire


enum ParamsSendType {
    case keyValuePair
    case jsonBody
}

typealias Parameters = [String:Any]

protocol ApiEndPoint {
    associatedtype Response: Codable
    
    var baseUrl: URL? { get }
    var endPoint: String { get }
    var parameters: Parameters? { get }
    
    var developmentType: DevelopmentType { get }
    var headers: HTTPHeaders? { get }
    var token: Bool { get }
    var method: HTTPMethod { get }
    var contentType: ContentType { get }
}

extension ApiEndPoint {
    
    var baseUrl: URL? {
        switch developmentType {
        case .development:
            return URL(string: MainUrls.DEVELOPMENT_URL)
        case .live:
            return URL(string: MainUrls.STAGING_URL)
        case .production:
            return URL(string: MainUrls.PRODUCTION_URL)
        }
    }
    
    var developmentType: DevelopmentType {
        get {
            .development
        }
    }
    
    var headers: HTTPHeaders? {
        token ? HTTPHeaders(["Accept": "application/json"]) : nil
    }
    
    var contentType: ContentType {
        .applicationJson
    }
}
