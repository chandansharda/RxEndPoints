//
//  ViewModle.swift
//  RxAlamofireApiEndPoint
//
//  Created by MAC on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation
import RxSwift

class ViewModle: ApiBuilder {
    
    func hitAndGetResponse(_ req: VEndPoint) {
        
        let observer = super.hitApi(withRequest: req)

        _ = observer.subscribe(onNext: { (userData) in
            print(userData.token ?? "")
        }, onError: { (error) in
            print(error.localizedDescription)
        }, onCompleted: {
            print("Completed")
        }) {
            print("All Killed")
        }.disposed(by: DisposeBag())
    }
}
