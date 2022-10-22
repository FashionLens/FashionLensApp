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
    @IBOutlet weak var passwordInput: UITextField!
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
        self.usernameInput.becomeFirstResponder()
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
