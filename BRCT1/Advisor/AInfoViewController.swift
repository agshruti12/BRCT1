//
//  AInfoViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 9/11/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AInfoViewController: UIViewController {

    @IBOutlet weak var clubName: UILabel!
    
    @IBOutlet weak var clubDescription: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var students:[String] = []
    var studentEmails:[String] = []
    
    var clubId:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        loadClubData()
        
        
    }
    
    func loadClubData() {
        
        let url = "http:192.168.1.41:3003/club/" + String(clubId)
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let clubData:JSON = JSON(response.result.value!)
                
                self.clubName.text = clubData[0]["club_name"].string
                self.clubDescription.text = clubData[0]["description"].string
                
                self.getStudents()
                
                                
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
        }
        
        
    }
    
    @IBAction func addEvent(_ sender: UIButton) {
    }
    
    func getStudents(){
        let url = "http:192.168.1.41:3003/usersinclub/" + String(clubId)
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let userData:JSON = JSON(response.result.value!)
                
                if (userData.count != 0) {
                    for index in 0...(userData.count - 1){
                        self.students.append(userData[index]["user_name"].string!)
                        self.studentEmails.append(userData[index]["user_email"].string!)
                    
                    
                    }
                }
                self.tableView.reloadData()
                                
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
        }
        
    }
}

extension AInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        cell.textLabel?.text = students[indexPath.row]
        return cell
    }
    
    
}

extension AInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(studentEmails[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

