//
//  TeacherLoginViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/4/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase

class AdvisorLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    self?.errorMessage.text = e.localizedDescription
                } else {
                    self?.performSegue(withIdentifier: "advisorLoggedIn", sender: self)
                }
            }
        }
    }
}
