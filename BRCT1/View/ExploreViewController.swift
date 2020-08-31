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
    
    
    let randomNames = ["shruti", "shrey", "papa", "mama"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
    }

    func getClubNames() -> [String] {
        return [""]
    }

}

extension ExploreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath)
        
        cell.textLabel?.text = randomNames[indexPath.row]
        return cell
    }
    
    
    
}

extension ExploreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("i was tapped!")
    }

    
}
