//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import Foundation
import UIKit

class DocumentDetailViewModel {
    
    var documentsDetail: [[String: Any]] = []
    
    init() {
        getData()
    }
    
    func getData() {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "detail", withExtension: "json")!)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            documentsDetail = json["data"] as! [[String: Any]]
            //print(documents)
        } catch {
            // Error reading documents.json
        }
    }
}

