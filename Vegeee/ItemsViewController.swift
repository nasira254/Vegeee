//
//  ItemsViewController.swift
//  Vegeee
//
//  Created by Nasir Ali on 11/09/2018.
//  Copyright © 2018 Nasir Ali. All rights reserved.
//

import UIKit
import Firebase


class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var itemTableView: UITableView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTableView.delegate = self
        itemTableView.dataSource = self
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        
        itemTableView.addGestureRecognizer(tapGesture)
        
        itemTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "customItemCell")
        
        configureTableView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customItemCell", for: indexPath) as! CustomItemCell

        let itemArray = ["tesjh", "test2", "test3"]

        cell.itemName.text = itemArray[indexPath.row]

        return cell

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @objc func tableViewTapped(){
        
        messageTextfield.endEditing(true)
    }
    
    
    func configureTableView() {
        
        itemTableView.rowHeight = UITableViewAutomaticDimension
        itemTableView.estimatedRowHeight = 120
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        
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
}
}



