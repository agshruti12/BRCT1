//
//  EventsViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/12/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct customCellData {
    
    let startTime : String!
    let endTime : String!
    let eventName : String!
    let clubName : String!
    let eventDate : String!
    
}

class EventsViewController: UITableViewController {

    var arrayOfCellData = [customCellData]()
    var eventDescrips = [String]()
    var selected:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getEventsData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
       
       cell.startTime.text = arrayOfCellData[indexPath.row].startTime
       cell.endTime.text = arrayOfCellData[indexPath.row].endTime
       cell.eventName.text = arrayOfCellData[indexPath.row].eventName
       cell.clubName.text = arrayOfCellData[indexPath.row].clubName
       cell.dateLabel.text = arrayOfCellData[indexPath.row].eventDate

       return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selected = indexPath.row
        performSegue(withIdentifier: "studentEventInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentEventInfo" {
            let destinationVC = segue.destination as! EventsInfoViewController
            
            destinationVC.cellData = [arrayOfCellData[selected].eventName, eventDescrips[selected], arrayOfCellData[selected].clubName, arrayOfCellData[selected].startTime, arrayOfCellData[selected].endTime, arrayOfCellData[selected].eventDate]
        }
    }
    
    func getEventsData() {
        let url  = "http:192.168.1.41:3003/eventsforstudent/" + String(FirstViewController.defaults.integer(forKey: "userId"))
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //worked
                let eventData:JSON = JSON(response.result.value!)
                
                if (eventData.count > 0) {
                    for index in 0...eventData.count - 1 {
                        let start = eventData[index]["event_start"].string
                        let end = eventData[index]["event_end"].string
                        let date = eventData[index]["event_date"].string
                        let title = eventData[index]["title"].string
                        let clubName = eventData[index]["club_name"].string
                        //let descrip = eventData[index]["description"]
                        self.eventDescrips.append(eventData[index]["description"].string!)
                        self.arrayOfCellData.append(customCellData(startTime: start, endTime: end, eventName: title, clubName: clubName, eventDate: date))
                    }
                    
                    self.tableView.reloadData()
                }
                
            } else {
                //didn't work
                print("error: \(String(describing: response.result.error))")
            }
        }
    }
    
    
}
