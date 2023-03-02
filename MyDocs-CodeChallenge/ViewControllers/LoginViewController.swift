//
//  ViewController.swift
//  MyDocs-CodeChallenge
//
//  Created by dhairya bhavsar on 2023-02-24.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import Firebase
import FirebaseAuth
import FirebaseCore

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var loginVM = LoginViewModel()
    
    //MARK: Viewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "dhairya"
        passwordTextField.text = "password"
    }
    
    //MARK: Button tap methods

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please enter your email and password.")
            return
        }
        if let _ = loginVM.authenticateUser(email: email, password: password) {
            let myDocsVC = storyboard?.instantiateViewController(withIdentifier: "MyDocsViewController") as! MyDocsViewController
            navigationController?.pushViewController(myDocsVC, animated: true)
        } else {
            showAlert(title: "Error", message: "Invalid email or password.")
            emailTextField.text = ""
            passwordTextField.text = ""
        }
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else{return}
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self){signInResult, err in
            
            if let error = err {
                print(error)
                return
            }

            guard
                let authentication = signInResult?.user,
                let idToken = authentication.idToken?.tokenString
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken.tokenString)
                        Auth.auth().signIn(with: credential) { result, error in
                            if let error = error {
                                print(error)
                                return
                            }
                let myDocsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyDocsViewController") as! MyDocsViewController
                self.navigationController?.pushViewController(myDocsVC, animated: true)
            }

        }
    }

    @IBAction func appleSignInViewTapped(_ sender: Any) {
                let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // User signed in with Apple
            _ = appleIDCredential.user
            _ = appleIDCredential.fullName
            _ = appleIDCredential.email
            // Handle user data as needed
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
    }
}


