//
//  ItemsViewController.swift
//  Vegeee
//
//  Created by Nasir Ali on 11/09/2018.
//  Copyright © 2018 Nasir Ali. All rights reserved.
//

import UIKit
import Firebase


class ItemsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
     try   Auth.auth().signOut()
           //below to navigate to root home page  navigationController?.popToRootViewController(animated: true)
    }
        catch {
            
            print("error, there was a problem")
            
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil
        
            else {
                print("no view controllers to pop off")
                return
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
    
//MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
}
