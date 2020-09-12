//
//  EventsViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/12/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

struct customCellData {
    
    let startTime : String!
    let endTime : String!
    let eventName : String!
    let clubName : String!
    let eventDate : String!
    
}

class EventsViewController: UITableViewController {

    var arrayOfCellData = [customCellData]()
    override func viewDidLoad() {
        super.viewDidLoad()

        arrayOfCellData = [customCellData(startTime: "3:00 pm", endTime: "5:00 pm", eventName: "Meeting1", clubName: "Robotics", eventDate: "January 1st, 2020"),
        customCellData(startTime: "4:00 pm", endTime: "6:00 pm", eventName: "Meeting2", clubName: "Art Club", eventDate: "January 2nd, 2020"),
        customCellData(startTime: "5:00 pm", endTime: "7:00 pm", eventName: "Meetin3", clubName: "Comp Sci Club", eventDate: "January 3rd, 2020")]
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
}
