//
//  StudentSignupViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/4/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var signupStatus: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var teacherButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signupPressed(_ sender: UIButton) {
        
        if studentButton.isSelected {
            print("student selected")
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
            
            //Make post request to add user here
            
        } else if teacherButton.isSelected {
            print("advisor selected")
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorMessage.text = e.localizedDescription
                    } else {
                        //Navigate to Student home page
                        self.performSegue(withIdentifier: "advisorSignedUp", sender: self)
                    }
                }
            }
            
            //Make post request to add user here
            
        }
    }
    
    
    @IBAction func userRoleChanged(_ sender: UIButton) {
        studentButton.isSelected = false
        teacherButton.isSelected = false
        sender.isSelected = true
        
        let title = sender.currentTitle
        
        if title == "Student" {
            signupStatus.text = "Student"
            
            
        } else if title == "Advisor" {
            signupStatus.text = "Advisor"
            
        }
    }
    
}
