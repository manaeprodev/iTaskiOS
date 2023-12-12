//
//  ViewController.swift
//  MonProjet
//
//  Created by etudiant on 19/10/2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickGetStarted(_ sender: UIButton) {
        guard let email = emailTextField.text else {
            return
        }
        guard let password = pwdTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "An error has occurred.", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                print("L'utilisateur est connecté!")
            }
        }
    }
}
