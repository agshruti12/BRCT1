//
//  ProfileViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 8/30/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import FirebaseAuth

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var clubs:[String] = []
    
    var userId:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
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
                    
                    self.getClubNames()
                    
                } else {
                    //didn't work
                    print("error: \(String(describing: response.result.error))")
                }
        }
    }
    
    func getClubNames() {
        let url = "http:192.168.1.41:3003/clubsofuser/" + String(userId)
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let clubNames:JSON = JSON(response.result.value!)
                
                for index in 0...clubNames.count {
                    self.clubs.append(clubNames[index]["club_name"].stringValue)
                }
                
                self.tableView.reloadData()
                
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            FirstViewController.defaults.set(false, forKey: "studentLoggedIn")
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

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "userClubCell", for: indexPath)

        cell.textLabel?.text = clubs[indexPath.row]
        return cell
    }
    
    
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("i was tapped!")
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
}

