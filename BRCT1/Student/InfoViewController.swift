//
//  InfoViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 8/31/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InfoViewController: UIViewController {

    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubDescription: UILabel!
    @IBOutlet weak var advisorName: UILabel!
    @IBOutlet weak var advisorEmail: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var clubId:Int = 0
    var registered:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        
        loadClubData()
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if (!registered) {
            let json = ["club_id":clubId, "user_id": FirstViewController.defaults.integer(forKey: "userId")]
            Alamofire.request("http:192.168.1.41:3003/registration_create", method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseData {response in
                if response.result.isSuccess {
                    //worked
                    print("success!")

                    self.registerButton.backgroundColor = UIColor(red: 55/255, green: 196/255, blue: 111/255, alpha: 1.0)
                    self.registerButton.setTitle("Registered", for: .normal)
                    
                    self.registered = true
                    
                } else {
                    //didn't work
                    print("error: \(String(describing: response.result.error))")
                }
            }
        }
        
        

        
    }
    
    func loadClubData() {
        print(clubId)
        
        let url = "http:192.168.1.41:3003/club/" + String(clubId)
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let clubData:JSON = JSON(response.result.value!)
                
                self.clubName.text = clubData[0]["club_name"].string
                self.clubDescription.text = clubData[0]["description"].string
                self.advisorName.text = clubData[0]["user_name"].string
                self.advisorEmail.text = clubData[0]["user_email"].string
                
                self.configureRegisterButton()
                
                                
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
        }
        
        
    }
    
    func configureRegisterButton() {
        let userId = FirstViewController.defaults.integer(forKey: "userId")
        let url = "http:192.168.1.41:3003/clubsofuser/" + String(userId)
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let clubNames:JSON = JSON(response.result.value!)
                
                for index in 0...clubNames.count {
                    if self.clubId == clubNames[index]["id"].int{
                        //if user is registered
                        self.registerButton.backgroundColor = UIColor(red: 55/255, green: 196/255, blue: 111/255, alpha: 1.0)
                        self.registerButton.setTitle("Registered", for: .normal)
                        self.registered = true
                        
                        
                    }
                }
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
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
