//
//  WelcomeViewController.swift
//  BodyDetection
//
//  Created by Richard Luo on 10/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var usernameInput: FloatingTextField!
    @IBOutlet weak var passwordInput: FloatingTextField!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func enterClick(_ sender: Any) {
        if let email = usernameInput.text, let password = passwordInput.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Warning!", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                            case .default:
                            print("default")
                            
                            case .cancel:
                            print("cancel")
                            
                            case .destructive:
                            print("destructive")
                            
                        @unknown default:
                            print("Not known error")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "fromLoginToAR", sender: self)
                }
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
        self.hideKeyboardOnTapAround()
        
        // Styling textfields
        usernameInput.borderStyle = UITextField.BorderStyle.roundedRect
        passwordInput.borderStyle = UITextField.BorderStyle.roundedRect
        
        // Add box shadow on enter button
        enterButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        enterButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        enterButton.layer.shadowOpacity = 1.0
        enterButton.layer.shadowRadius = 10.0
        enterButton.layer.masksToBounds = false
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}
