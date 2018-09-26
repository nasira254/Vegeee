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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let items : ItemModel
        items = itemList[indexPath.row]
        
        
        cell.labelName.text = items.name
        cell.labelPrice.text = items.price
        
        
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
    
    func deleteItem(id: String){
        refItems.child(id).setValue(nil)
        
        
        
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        addItems()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
          refItems = Database.database().reference().child("items")
        
        refItems.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.itemList.removeAll()
                
                for items in snapshot.children.allObjects as! [DataSnapshot]{
                    let itemObject = items.value as? [String: AnyObject]
                    let itemName = itemObject? ["ItemName"]
                    let itemPrice = itemObject? ["ItemPrice"]
                    let itemId = itemObject? ["id"]
                    
                    let item = ItemModel(id: itemId as! String?, name: itemName as! String?, price: itemPrice as! String?)
                    
                    self.itemList.append(item)
                }
                self.tableItems.reloadData()
                
                
            }
        })
        
        
    }

    func addItems(){
        
        let key = refItems.childByAutoId().key
        let items = ["id" : key,
                     "ItemName" : itemNameTextField.text! as String,
                     "ItemPrice" : itemPriceTextField.text! as String]
        
        refItems.child(key).setValue(items)
        
        messageLabel.text = "Item added";
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
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
