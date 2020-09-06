//
//  LoginViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 8/30/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    static var profileData:JSON!
    
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
                    
                    let url = "http:192.168.1.41:3003/userwithemail/" + email
                    
                    
                    Alamofire.request(url, method: .get).responseJSON {
                            response in
                            if response.result.isSuccess {
                                //worked
                                let userData:JSON = JSON(response.result.value!)
                                LoginViewController.profileData = userData
                                let isStudent = (userData[0]["isStudent"].int)
                                
                                print(isStudent!)
                                
                                if isStudent == 1 {
                                    //perform student segue
                                    self?.performSegue(withIdentifier: "studentLoggedIn", sender: self)
                                } else {
                                    //perform advisor segue
                                    self?.performSegue(withIdentifier: "advisorLoggedIn", sender: self)
                                }
                                
                            } else {
                                //didn't work
                                print("error: \(String(describing: response.result.error))")
                            }
                    }
                    
                    
                }
            }
        }
    }
    
//    func studentStatus(_ email: String) -> Bool {
//        let url = "http:192.168.1.41:3003/userwithemail/" + email
//
//
//        Alamofire.request(url, method: .get).responseJSON {
//                response in
//                if response.result.isSuccess {
//                    //worked
//                    let userData:JSON = JSON(response.result.value!)
//                    let isStudent = (userData[0]["isStudent"].int)
//
//                    print(isStudent!)
//
//                    if isStudent == 1 {
//                        //perform student segue
//
//                    } else {
//                        //perform advisor segue
//
//                    }
//
//                } else {
//                    //didn't work
//                    print("error: \(String(describing: response.result.error))")
//                }
//        }
//
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
