//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import Foundation
import UIKit

class User {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    convenience init?(jsonData: [String: Any]) {
        guard let email = jsonData["email"] as? String,
              let password = jsonData["password"] as? String else {
            return nil
        }
        self.init(email: email, password: password)
    }
}

