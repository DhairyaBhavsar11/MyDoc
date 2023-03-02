//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import UIKit

class MyDocCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpData(document : [String: Any]) {
        
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.darkGray.cgColor

        
//        layer.masksToBounds = true
//        layer.cornerRadius = 1
//        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
//        let document = documents[indexPath.row]
        lblTitle.text = document["name"] as? String
        lblDescription.text = document["description"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let createdAtString = document["created_at"] as? String, let createdAt = dateFormatter.date(from: createdAtString) {
            dateFormatter.timeZone = TimeZone.current
            lblDate?.text? = (dateFormatter.string(from: createdAt))
        }
        if let status = document["status"] as? String {
            if(status == "new"){
                let new = "New"
                lblStatus.text = new
                lblStatus?.textColor = status == "new" ? .red : .green
            }else{
                let completed = "Completed"
                lblStatus.text = completed
                lblStatus?.textColor = .systemGreen
            }
            
        }
    }
    
}
