//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import UIKit

class DocumentDetailViewController: BaseViewController {

    
    @IBOutlet weak var checkBoxStackView: UIStackView!
    @IBOutlet var checkBoxBtns: [UIButton]!
    @IBOutlet weak var CheckBoxView: UIView!
    
    @IBOutlet weak var radioStackView: UIStackView!
    @IBOutlet var radioBtns: [UIButton]!
    @IBOutlet weak var radioBtnView: UIView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblHeadingDoc: UILabel!
    @IBOutlet weak var lblDocDescription: UILabel!
    @IBOutlet weak var txtFieldInput: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var documentDetail : [String: Any] = [:]
    var docDetailVM = DocumentDetailViewModel()
    
    
    // MARK: - UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadRadioButtonUI()
        loadCheckBoxUI()
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Other methods
    
    private func setUpUI() {
        txtDescription.text = ""
        lblTitle.text = documentDetail["name"] as? String
        txtDescription.text = documentDetail["description"] as? String
        lblDescription.text = documentDetail["description"] as? String
        lblCreatedAt.text = documentDetail["created_at"] as? String
        lblHeadingDoc.text = documentDetail["title"] as? String
        lblDocDescription.text = documentDetail["description_1"] as? String
        txtFieldInput.text = documentDetail["place_holder"] as? String
  
        if documentDetail["completed"] as? String == "NA" {
            btnSubmit.isHidden = false
            lblStatus.isHidden = true
        }else{
            btnSubmit.isHidden = true
            lblStatus.text = documentDetail["completed_at"] as? String
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if txtFieldInput.text?.isEmpty ?? true{
            showAlert(title: "Error", message: "Please Fill All Field.")
            return
        }else{
            //saveJSON()
            let myDocsVC = storyboard?.instantiateViewController(withIdentifier: "MyDocsViewController") as! MyDocsViewController
            navigationController?.pushViewController(myDocsVC, animated: true)
        }
    }
    
    private func loadRadioButtonUI(){
        for button in radioBtns {
            button.setImage(UIImage(named: "unselected_radio_button"), for: .normal)
            button.setImage(UIImage(named: "selected_radio_button"), for: .selected)
            button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        }
        
        // Add the radio buttons to the stack view
        for button in radioBtns {
            radioStackView.addArrangedSubview(button)
        }
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        // Deselect all the other radio buttons
        for button in radioBtns {
            if button == sender {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }

        // Scroll to the selected radio button
        if let index = radioBtns.firstIndex(of: sender) {
            _ = radioStackView.arrangedSubviews[index].frame
        }
    }
    
    private func loadCheckBoxUI(){
        for button in checkBoxBtns {
            button.setImage(UIImage(named: "check-box"), for: .normal)
            button.setImage(UIImage(named: "check"), for: .selected)
            button.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
        }
        
        // Add the radio buttons to the stack view
        for button in checkBoxBtns {
            checkBoxStackView.addArrangedSubview(button)
        }
    }
    
    @objc func checkBoxTapped(_ sender: UIButton) {
        // Deselect all the other radio buttons
        for button in checkBoxBtns {
            if button == sender && button.isSelected == false{
                button.isSelected = true
            }else if button.isSelected == true && button == sender{
                button.isSelected = false
            }
        }
        // Scroll to the selected radio button
        if let index = checkBoxBtns.firstIndex(of: sender) {
            _ = checkBoxStackView.arrangedSubviews[index].frame
        }
    }
    

}
