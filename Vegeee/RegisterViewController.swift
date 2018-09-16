//
//  RegisterViewController.swift
//  Vegeee
//
//  Created by Nasir Ali on 10/09/2018.
//  Copyright © 2018 Nasir Ali. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    var refBusiness: DatabaseReference!
    
    
    @IBOutlet weak var businessTextField: UITextField!
    
    @IBOutlet weak var firstlineAddreesTextfield: UITextField!
    @IBOutlet weak var secondAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var businessNumberTextField: UITextField!
    @IBOutlet weak var businessMobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refBusiness = Database.database().reference().child("Business");
        
    }

    func addBusiness(){
        let key = refBusiness.childByAutoId().key
        let business = ["id": key,
                        "businessName": businessTextField.text! as String,
                        "firstLineOfAddress": firstlineAddreesTextfield.text! as String,
                        "secondlineOfAddress": secondAddressTextField.text! as String,
                        "city": cityTextField.text! as String,
                        "postcode": postcodeTextField.text! as String,
                        "businessPhone": businessNumberTextField.text! as String,
                        "businessMobile": businessMobileTextField.text! as String,
                        "email": emailTextField.text! as String,
                        "password": passwordTextField.text! as String,]
        
        refBusiness.child(key).setValue(business)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        addBusiness()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            }else {
                //success
                print("Registration Success")
                //add self. at begining as you're in closure
                self.performSegue(withIdentifier: "goToItems", sender: self)
                
            }
        }
        
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
