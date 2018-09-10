//
//  ViewController.swift
//  Vegeee
//
//  Created by Nasir Ali on 10/09/2018.
//  Copyright © 2018 Nasir Ali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }


    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToLogin", sender: self)
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToRegistration", sender: self)
    }
    
}

