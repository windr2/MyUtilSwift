//
//  FirebaseAuthViewController.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 30..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseAuthViewController: UIViewController {
    
    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Username.text = "windr2@nate.com"
        Password.text = "123456"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: AnyObject){
        print("clikc create user btn");
        
        FIRAuth.auth()?.createUserWithEmail(Username.text! , password: Password.text! ,
            completion: {
                user , error in
                if error != nil {
                    self.login()
                }else {
                    print ("User")
                    self.login()
                    
                }
        
        })
        
    }
    
    func login(){
        
        print("id : \(Username.text)   paw : \(Password.text)")
        FIRAuth.auth()?.signInWithEmail(Username.text! , password: Password.text! ,
            completion: {
                user , error in
                if error != nil {
                    print ("incorrent")
                    
                }else {
                    print ("User")
                                                
                }
                                            
        })
    }
    
}