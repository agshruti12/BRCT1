//
//  NewEventViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 9/17/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI

class NewEventViewController: UIViewController {
    
    var clubId:Int!

    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var descripField: UITextField!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEvent(_ sender: Any) {
        if let title = eventField.text, let descrip = descripField.text, let startTime = startField.text, let endTime = endTime.text, let date = dateField.text {
            let json = ["title":title, "description": descrip,"start":startTime, "end": endTime, "date":date, "club_id": clubId!] as [String : Any]
            Alamofire.request("http:192.168.1.41:3003/event_create", method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseData {response in
                if response.result.isSuccess {
                    //worked
                    print("success!")
                    
                    //send an email
                    self.showMailComposer()
                    
                    self.navigationController?.popViewController(animated: true)

                } else {
                    //didn't work
                    print("error: \(String(describing: response.result.error))")
                }
            }
            
            
        }
        
    }
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["agshrey@gmail.com"])
        composer.setSubject("New Event for Club Whatever!")
        composer.setMessageBody("There is a new event at this time on this date for this club", isHTML: false)
        
        present(composer, animated: true)
    }

}

extension NewEventViewController: MFMailComposeViewControllerDelegate {
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
        }
        controller.dismiss(animated: true)
    }
}
