//
//  MyClubsController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/10/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyClubsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var clubs:[String] = []
    
    var clubIds:[Int] = []
       
    var selected:Int!
          
          
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      
      tableView.dataSource = self
      tableView.delegate = self
      
      getClubNames()

      
    }
          

    func getClubNames() {
       let userId = FirstViewController.defaults.integer(forKey: "userId")
       let url = "http:192.168.1.41:3003/clubsofadvisor/" + String(userId)
           
       
          Alamofire.request(url, method: .get).responseJSON {
              response in
              if response.result.isSuccess {
                  //worked
                  let clubNames:JSON = JSON(response.result.value!)
                  
                  for index in 0...(clubNames.count-1) {
                    self.clubs.append(clubNames[index]["club_name"].stringValue)
                    
                    self.clubIds.append(clubNames[index]["id"].int!)
                  }
                  
                  self.tableView.reloadData()
                  
              } else {
                  //didn't work
                  print("error: \(String(describing: response.result.error))")
              }
          }
      }
    
    @IBAction func newClubPressed(_ sender: UIButton) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdvisorInfo" {
            let destinationVC = segue.destination as! AInfoViewController
            
            destinationVC.clubId = clubIds[selected]
            
        }
    }
    

}

extension MyClubsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "advisorClubCell", for: indexPath)

        cell.textLabel?.text = clubs[indexPath.row]
        return cell
    }
    
}

extension MyClubsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selected = indexPath.row
                
        performSegue(withIdentifier: "toAdvisorInfo", sender: self)
    }
    
    
}



