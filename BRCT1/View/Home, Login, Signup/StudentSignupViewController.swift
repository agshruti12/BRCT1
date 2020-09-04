//
//  StudentSignupViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/4/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase

class StudentSignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signupPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorMessage.text = e.localizedDescription
                } else {
                    //Navigate to Student home page
                    self.performSegue(withIdentifier: "studentSignedUp", sender: self)
                }
            }
        }
    }
}
