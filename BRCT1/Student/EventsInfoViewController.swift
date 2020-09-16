//
//  EventsInfoViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/16/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

class EventsInfoViewController: UIViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addToCalenderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addToCalenderButton.layer.cornerRadius = 10

    }
    
    @IBAction func addToCalenderPressed(_ sender: Any) {
    }
}
