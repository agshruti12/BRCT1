//
//  AddClubViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 9/12/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddClubViewController: UIViewController {

    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var errorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        errorText.text = ""
        
        
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        if let name = nameText.text, let descrip = descriptionText.text {
            if descrip.count >= 2000 {
                errorText.text = "Exceeded character limit for club description."
            }
            else {
                let json = ["name":name, "description": descrip,"advisor_id":FirstViewController.defaults.integer(forKey: "userId") ] as [String : Any]
                Alamofire.request("http:192.168.1.41:3003/club_create", method: .post, parameters: json, encoding: JSONEncoding.default)
                .responseData {response in
                    if response.result.isSuccess {
                        //worked
                        print("success!")
                        self.navigationController?.popViewController(animated: true)

                    } else {
                        //didn't work
                        print("error: \(String(describing: response.result.error))")
                    }
                }
                
            }
            
        }
        
        
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
