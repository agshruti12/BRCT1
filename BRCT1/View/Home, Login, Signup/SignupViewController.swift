//
//  StudentSignupViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/4/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Alamofire

class SignupViewController: UIViewController {
    
    @IBOutlet weak var signupStatus: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var teacherButton: UIButton!
    
    static var profileData:[Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signupPressed(_ sender: UIButton) {
        
        if studentButton.isSelected {
            print("student selected")
            if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorMessage.text = e.localizedDescription
                    } else {
                        //Navigate to Student home page
                        let json = ["name":name, "email": email, "password":password, "isStudent":true] as [String : Any]
                        Alamofire.request("http:192.168.1.41:3003/user_create", method: .post, parameters: json, encoding: JSONEncoding.default)
                        .responseJSON {response in
                            if response.result.isSuccess {
                                //worked
                                print("success!")
        
                            } else {
                                //didn't work
                                print("error: \(String(describing: response.result.error))")
                            }
                        }
                        self.performSegue(withIdentifier: "studentSignedUp", sender: self)
                    }
                }
            }
            
            //Make post request to add user here
            
        } else if teacherButton.isSelected {
            print("advisor selected")
            if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorMessage.text = e.localizedDescription
                    } else {
                        let json = ["name":name, "email": email, "password":password, "isStudent":false] as [String : Any]
                        Alamofire.request("http:192.168.1.41:3003/user_create", method: .post, parameters: json, encoding: JSONEncoding.default)
                        .responseJSON {response in
                            if response.result.isSuccess {
                                //worked
                                print("success!")
        
                            } else {
                                //didn't work
                                print("error: \(String(describing: response.result.error))")
                            }
                        }
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
