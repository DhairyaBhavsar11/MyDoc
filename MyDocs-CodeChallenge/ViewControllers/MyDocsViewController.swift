//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import UIKit

class MyDocsViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var documents: [[String: Any]] = []
    let cellSpacing: CGFloat = 10
    
    var myDocVM = MyDocViewModel()
    
    //MARK: UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    //MARK: Custom methods
    
    private func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MyDocsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDocVM.documents.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDocCell", for: indexPath) as! MyDocCell
        cell.selectionStyle = .none
        cell.setUpData(document: myDocVM.documents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DocumentDetailViewController") as! DocumentDetailViewController
        detailVC.documentDetail = myDocVM.documentsDetail[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
