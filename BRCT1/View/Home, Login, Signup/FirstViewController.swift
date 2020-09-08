//
//  FirstViewController.swift
//  BRCT1
//
//  Created by Shrey Agarwal on 9/4/20.
//  Copyright © 2020 Shruti Agarwal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    static let defaults = UserDefaults.standard
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        if FirstViewController.defaults.bool(forKey: "studentLoggedIn") == true {
            performSegue(withIdentifier: "studentAutoLogin", sender: self)
        }
        
        if FirstViewController.defaults.bool(forKey: "advisorLoggedIn") == true {
            performSegue(withIdentifier: "teachAutoLogin", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}
