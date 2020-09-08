//
//  InfoViewController.swift
//  BRCT1
//
//  Created by Shruti Agarwal on 8/31/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubDescription: UILabel!
    @IBOutlet weak var advisorName: UILabel!
    @IBOutlet weak var advisorEmail: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
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
