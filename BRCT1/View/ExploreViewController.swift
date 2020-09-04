//
//  SecondViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 8/27/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var clubs:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getClubNames()

        
    }
    

    func getClubNames() {
        Alamofire.request("http:192.168.1.41:3003/clubnames", method: .get).responseJSON {
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

}

extension ExploreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath)

        cell.textLabel?.text = clubs[indexPath.row]
        return cell
    }
    
    
    
}

extension ExploreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("i was tapped!")
        
        
    }

    
}
