//
//  EmailValidator.swift
//  RxAlamofireApiEndPoint
//
//  Created by MAC on 05/09/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import Foundation

@propertyWrapper
struct Email<Value: StringProtocol> {
    var value: Value?

    var wrappedValue: Value? {
        get {
            return validate(email: value) ? value : nil
        }
        set {
            value = newValue
        }
    }
    
    private func validate(email: Value?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
