//
//  AEventInfoViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 9/17/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

class AEventInfoViewController: UIViewController {

    var cellData = [String]()
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescrip: UILabel!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

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

}
