//
//  ViewController.swift
//  RxAlamofireApiEndPoint
//
//  Created by MAC on 30/08/20.
//  Copyright © 2020 Chandan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @Email
    var email: String?

    var viewModle: ViewModle? = ViewModle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email = "hello@mail.com"
        print(email)
        viewModle?.hitAndGetResponse(.login(["email": "lokesh@sha.com" , "password": "123456"]))
    }
}

