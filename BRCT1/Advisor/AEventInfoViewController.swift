//
//  AEventInfoViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 9/17/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import EventKit
import MessageUI

class AEventInfoViewController: UIViewController {

    var cellData = [String]()
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescrip: UILabel!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var addCalendar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScreen()
    }
    
    func configureScreen(){
           eventName.text = cellData[0]
           eventDescrip.text = cellData[1]
           clubName.text = cellData[2]
           startTime.text = cellData[3]
           endTime.text = cellData[4]
           dateLabel.text = cellData[5]
       }
    
    @IBAction func addToCalendar(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func insertEvent(start: Date, end: Date, eventName: String, eventNotes: String) {
        let eventStore: EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted && (error == nil) {
                print("granted: \(granted)")
                print("error: \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = eventName
                event.startDate = start
                event.endDate = end
                event.notes = eventNotes
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("error: \(error)")
                }
                print("saved event")
                
            } else {
                print(error)
            }
        }
    }
    
    
    @IBAction func addToCalendarPressed(_ sender: UIButton) {
        
        let name = eventName.text!
        let startttime = startTime.text!
        let endtime = endTime.text!
        let date = dateLabel.text!
        let summary = eventDescrip.text!
        let start = convertStringToDate(dateString: date, timeString: startttime)
        let end = convertStringToDate(dateString: date, timeString: endtime)
        print(start)
        print(end)
        insertEvent(start: start, end: end, eventName: name, eventNotes: summary)
        addCalendar.setTitle("Added", for: .normal)
        //checkPermission(startDate: start, endDate: end, eventTitle: date)
    }
}

extension AEventInfoViewController {
    func convertStringToDate (dateString: String!, timeString: String) -> Date{
        var startTime = timeString
        if startTime.hasSuffix("M") {
            startTime.removeLast()
            if startTime.hasSuffix("A") {
                startTime.removeLast()
                var start = startTime
                start.removeLast()
                start.removeLast()
                start.removeLast()
                
                var hour = Int(String(start))
                hour! += 5
                let unwrappedHour = hour!
                
                let stringVersion = String(unwrappedHour)
                
                if start.count == 1 {
                    startTime.removeFirst()
                } else if start.count == 2 {
                    startTime.removeFirst()
                    startTime.removeFirst()
                }
                
                startTime = stringVersion + startTime + ":00+0000"
            }
            else if startTime.hasSuffix("P") {
                startTime.removeLast()
                var start = startTime
                start.removeLast()
                start.removeLast()
                start.removeLast()
                
                var hour = Int(String(start))
                hour! += 17
                let unwrappedHour = hour!
                
                let stringVersion = String(unwrappedHour)
                
                if start.count == 1 {
                    startTime.removeFirst()
                } else if start.count == 2 {
                    startTime.removeFirst()
                    startTime.removeFirst()
                }
                
                startTime = stringVersion + startTime + ":00+0000"
            }
        }
        
        let words = dateString.split(separator: " ")
        var date = words[1]
        let month = words[0]
        let year = words[2]
        
        date.removeLast()
        if date.count == 1 {
            date = "0" + date
        }
        var monthNumber:String = ""
        
        if month.hasPrefix("J") { monthNumber = "01" }
        else if month.hasPrefix("F") {  monthNumber = "02" }
        else if month.hasPrefix("Mar") {  monthNumber = "03" }
        else if month.hasPrefix("Ap") { monthNumber = "04" }
        else if month.hasPrefix("May") { monthNumber = "05" }
        else if month.hasPrefix("Jun") { monthNumber = "06" }
        else if month.hasPrefix("Jul") { monthNumber = "07" }
        else if month.hasPrefix("Au") { monthNumber = "08" }
        else if month.hasPrefix("S") { monthNumber = "09" }
        else if month.hasPrefix("O") { monthNumber = "10" }
        else if month.hasPrefix("N") { monthNumber = "11" }
        else if month.hasPrefix("D") { monthNumber = "12" }
        
        
        let finalFormattedString = "\(year)-\(monthNumber)-\(date)T\(startTime)"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFromString = dateFormatter.date(from: finalFormattedString)
        let finalDate = dateFromString!
        return finalDate
    }
    
    
}
