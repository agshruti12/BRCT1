//
//  EventsInfoViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/16/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import EventKit
import MessageUI

class EventsInfoViewController: UIViewController {
    
    var cellData = [String]()
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
    }
    
    func configureScreen(){
        eventNameLabel.text = cellData[0]
        eventDescriptionLabel.text = cellData[1]
        clubNameLabel.text = cellData[2]
        startTimeLabel.text = cellData[3]
        endTimeLabel.text = cellData[4]
        dateLabel.text = cellData[5]
        
    }
    
    func checkPermission(startDate: Date, endDate: Date, eventTitle: String) {
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            eventStore.requestAccess(to: .event) { (status, error) in
                if status {}
                else {
                    print(error?.localizedDescription ?? "an error occurred")
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorized:
            print("Authorized")
            self.insertEvent(store: eventStore, startDate: startDate, endDate: endDate, eventName: eventTitle)
        @unknown default:
            print("Uknown")
        }
    }
    
    //Calendar
    func insertEvent (store: EKEventStore, startDate: Date, endDate: Date, eventName: String) {
        print("inserting event")
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            if calendar.title == "Home" {
                print("in home calender")
                let event = EKEvent(eventStore: store)
                event.startDate = startDate
                event.title = eventName
                
                event.endDate = endDate
//                let reminder1 = EKAlarm(relativeOffset: -60)
//                let reminder2 = EKAlarm(relativeOffset: -300)
//                event.alarms = [reminder1, reminder2]
                
                do {
                    try store.save(event, span: .thisEvent)
                    print("event insert")
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    @IBAction func addToCalenderPressed(_ sender: UIButton) {
        
        let startttime = startTimeLabel.text!
        let endtime = endTimeLabel.text!
        let date = dateLabel.text!
        let start = convertStringToDate(dateString: date, timeString: startttime)
        let end = convertStringToDate(dateString: date, timeString: endtime)
        print(start)
        print(end)
        checkPermission(startDate: start, endDate: end, eventTitle: date)
        
        
    }
    
    @IBAction func yesPressed(_ sender: UIButton) {
        let eventName = eventNameLabel.text!
        showMailComposer(status: "Yes", eventName: eventName)
    }
    @IBAction func noPressed(_ sender: UIButton) {
        let eventName = eventNameLabel.text!
        showMailComposer(status: "No", eventName: eventName)
    }
}

//Converting String to Date
extension EventsInfoViewController {
    func convertStringToDate (dateString: String!, timeString: String) -> Date{
        var startTime = timeString
        if startTime.hasSuffix("M") {
            startTime.removeLast()
            if startTime.hasSuffix("A") {
                startTime.removeLast()
                startTime = startTime + ":00+0000"
            }
            else if startTime.hasSuffix("P") {
                startTime.removeLast()
                var firstNumber = Int(String(startTime.first!))
                firstNumber! += 12
                let unwrappedFirstNumber = firstNumber!
                let stringVersion = String(unwrappedFirstNumber)
                startTime.removeFirst()
                startTime = stringVersion + startTime + ":00+0000"
            }
        }
        
        let typedDate = "January 17, 2020"
        let words = typedDate.split(separator: " ")
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

// Mail
extension EventsInfoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        
        switch result {
        case.cancelled:
            print("Cancelled")
        case .saved:
            print("Saved")
        case .sent:
            print("Sent")
        case .failed:
            print("Failed to send")
        @unknown default:
            fatalError("unknown error")
        }
        controller.dismiss(animated: true)
    }
    
    func showMailComposer(status: String, eventName: String) {
        
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        
        composer.setToRecipients(["agshrey@gmail.com"])
        if status == "Yes" {
            composer.setSubject("I'll be there!")
            composer.setMessageBody("Hi, I can make it to \(eventName)", isHTML: false)
        } else if status == "No" {
        composer.setSubject("Sorry, I can't attend")
        composer.setMessageBody("Sorry, I can't make it to \(eventName)", isHTML: false)
        }
        present(composer, animated: true)
    }
}
