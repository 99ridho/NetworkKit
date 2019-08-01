//
//  ViewController.swift
//  NetworkKitExample
//
//  Created by Ridho Pratama on 01/08/19.
//  Copyright © 2019 Ridho Pratama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let service = DefaultGithubService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        service.fetchUser(byUsername: "99ridho") { (result) in
            switch result {
            case let .success(user):
                print(user)
            case let .failure(error):
                print(error)
            }
        }
    }


}

