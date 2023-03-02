//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import Foundation

class LoginViewModel {
    
    private var documents: [[String: Any]] = []
    
    func authenticateUser(email: String, password: String) -> User? {
        // Load user data from local stored json api
        guard let usersData = loadUsersDataFromJsonApi() else {
            // Unable to load user data, return nil
            return nil
        }
        
        // Search for user with matching email and password
        for userData in usersData {
            print(usersData)
            if let user = User(jsonData: userData), user.email == email && user.password == password {
                return user // Authentication successful, return User object
            }
        }
        
        // No matching user found, authentication unsuccessful
        return nil
    }
    
    
    private func loadUsersDataFromJsonApi() -> [[String: Any]]? {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "users", withExtension: "json")!)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            documents = json["data"] as! [[String: Any]]
//            print(documents)
            return documents
        } catch {
            // Error reading documents.json
        }
        return nil
    }
    
}
