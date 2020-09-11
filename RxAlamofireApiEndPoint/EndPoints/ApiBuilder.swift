//
//  ApiBuilder.swift
//  RxAlamofireApiEndPoint
//
//  Created by Chandan Sharda on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class ApiBuilder: NSObject {
    
    private let session: Reactive<Session> = AF.rx
    private var runningSession: Observable<DataRequest>?
    private let disposable: DisposeBag = DisposeBag()
    
    
    func cancelAllRequest(completion: @escaping () -> Void) {
        session.base.cancelAllRequests(completingOnQueue: .main) {
            completion()
        }
    }
    
    /**
        Main method of making request
     - can accept only ApiEndPoint type objects
     - return bindable object 
     */
    
    func makeRequest<T: ApiEndPoint>(withRequest req: T) -> Observable<T.Response> {
        
        //making url from generic request
        guard let url = self.urlForEndpoint(req) else {
            return Observable.error(ApiErrors.urlNotCorrect)
        }
        
        //making session of api request
        runningSession = session.request(req.method, url, parameters: req.parameters, headers: makeHeaders(req), interceptor: nil)
        
        //returning observable object that can return result in success or error in faliure
        return Observable.create { [weak self] (observer)  in
            guard let self = self else {
                return Disposables.create {
                    observer.onError(ApiErrors.noInstanceFound)
                }
            }
            
            self.runningSession?.asObservable()
                .retry(2)
                .subscribe(onNext: { (response) in
                    response.validate(statusCode: 200 ..< 300).responseJSON { (dataResponse) in
                        
                        switch dataResponse.result {
                        case .success(let response):
                            do {
                                NetworkLogger.log(response: dataResponse.response)
                                let data = try JSONSerialization.data(withJSONObject: (response as! [String:Any])["body"] as Any, options: .prettyPrinted)
                                let decodable = try JSONDecoder().decode(T.Response.self, from: data)
                                
                                observer.onNext(decodable)
                                observer.onCompleted()
                                
                            } catch {
                                observer.onError(error)
                            }
                        case .failure(let error):
                            observer.onError(error)
                            observer.onCompleted()
                        }
                    }
                    
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposable)
            
            return Disposables.create { [weak self] in
                self?.cancelAllRequest {
                    print("Task Cancelled or Hope For Completed🤞🤞🤞")
                }
            }
        }
    }
    
    private func urlForEndpoint<T: ApiEndPoint>(_ request: T) -> URL? {
        return URL(string: request.endPoint, relativeTo: request.baseUrl)
    }
    
    /**
        Function to make headers for url request
     */
    private func makeHeaders<T: ApiEndPoint>(_ request: T) -> HTTPHeaders? {
        var head: [String:String] = [:]
        head = request.contentType.getDescription
        head.updateValue((request.headers?.first?.value ?? ""), forKey: (request.headers?.first?.name ?? ""))
        return HTTPHeaders(head)
    }
}
