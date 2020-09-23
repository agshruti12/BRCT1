//
//  EventsInfoViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/16/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

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
    
    @IBAction func addToCalenderPressed(_ sender: Any) {
    }
}
