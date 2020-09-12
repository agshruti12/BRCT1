//
//  AdvisorProfileViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/10/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseAuth


class AdvisorProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    var userId:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        userId = FirstViewController.defaults.integer(forKey: "userId")

            getProfileData()
    }
        
        func getProfileData() {
            
            let url = "http:192.168.1.41:3003/user/" + String(userId)
            
            Alamofire.request(url, method: .get).responseJSON {
                    response in
                    if response.result.isSuccess {
                        //worked
                        let userData:JSON = JSON(response.result.value!)
                                            
                        self.nameLabel.text = userData[0]["user_name"].stringValue
                        self.emailLabel.text = userData[0]["user_email"].stringValue
                                                
                    } else {
                        //didn't work
                        print("error: \(String(describing: response.result.error))")
                    }
            }
        }
    
  
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            FirstViewController.defaults.set(false, forKey: "advisorLoggedIn")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



