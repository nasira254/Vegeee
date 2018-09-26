//
//  AdminViewController.swift
//
//
//  Created by Nasir Ali on 25/09/2018.
//

import UIKit
import Firebase

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refItems : DatabaseReference!
    
//
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
        
    }
    //to dsiplay the content in tablew view using the item model created
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let items : ItemModel
        items = itemList[indexPath.row]
        // all the label in the selected row
        cell.labelName.text = items.name
        cell.labelPrice.text = items.price
        //to call the values in that cell
        return cell
    }
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tableItems: UITableView!
    
    var itemList = [ItemModel] ()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemList[indexPath.row]
        
        let alertController = UIAlertController(title: item.name, message: "Give new value", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "update", style: .default) { (_) in
            
            let id = item.id
            
            let name = alertController.textFields?[0].text
            let price = alertController.textFields?[1].text
            
            self.updateItem(id: id!, name: name!, price: price!)
            
        }
        
        let deleteAction = UIAlertAction(title: "delete", style: .default) { (_) in
            
            self.deleteItem(id: item.id!)
        }
        alertController.addTextField { (textField) in
            textField.text = item.name
        }
        
        alertController.addTextField { (textField) in
            textField.text = item.price
            
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateItem(id: String, name: String, price: String){
        
        let item = ["id": id,
                    "ItemName": name,
                    "ItemPrice": price]
        
        refItems.child(id).setValue(item)
        messageLabel.text = "item updated"
        
    }
    //to delete item by item id selected
    func deleteItem(id: String){
        refItems.child(id).setValue(nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        //function called when button is pressed
        addItems()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting category in firebase db items
        refItems = Database.database().reference().child("items")
        
       //observing if any items in the category and display
        refItems.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount>0 {
                self.itemList.removeAll()
                
                // setting object values
                for items in snapshot.children.allObjects as! [DataSnapshot]{
                    let itemObject = items.value as? [String: AnyObject]
                    let itemName = itemObject? ["ItemName"]
                    let itemPrice = itemObject? ["ItemPrice"]
                    let itemId = itemObject? ["id"]
                    
                    //setting data type
                    let item = ItemModel(id: itemId as! String?, name: itemName as! String?, price: itemPrice as! String?)
                    
                    //making a liost
                    self.itemList.append(item)
                }
                //then loading that list available
                self.tableItems.reloadData()
            }
        })
    }
    
    //function to add vegetable items
    func addItems(){
        //setting values
        let key = refItems.childByAutoId().key
        let items = ["id" : key,
                     "ItemName" : itemNameTextField.text! as String,
                     "ItemPrice" : itemPriceTextField.text! as String]
        
        refItems.child(key).setValue(items)
        
        //label message to say item added
        messageLabel.text = "Item added";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

