//
//  NewListController.swift
//  MonProjet
//
//  Created by etudiant on 12/12/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

class NewListController: UIViewController {
    
    
    @IBOutlet weak var listName: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var word1Button: UITextField!
    
    @IBOutlet weak var word2Button: UITextField!
    
    @IBOutlet weak var word3Button: UITextField!
    
    @IBOutlet weak var word4Button: UITextField!
    
    @IBOutlet weak var word5Button: UITextField!
    
    @IBOutlet weak var word6Button: UITextField!
    
    @IBOutlet weak var word7Button: UITextField!
    
    @IBOutlet weak var word8Button: UITextField!
    
    @IBOutlet weak var match1Button: UITextField!
    
    @IBOutlet weak var match2Button: UITextField!
    
    @IBOutlet weak var match3Button: UITextField!
    
    @IBOutlet weak var match4Button: UITextField!
    
    @IBOutlet weak var match5Button: UITextField!
    
    @IBOutlet weak var match6Button: UITextField!
    
    @IBOutlet weak var match7Button: UITextField!
    
    @IBOutlet weak var match8Button: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let db = Firestore.firestore()
            let firebaseCollection = db.collection(currentUserEmail as String)
            
            if let documentName = listName.text, !documentName.isEmpty {
                
                var jsonData = [String: String]()
                
                func addToJson(_ word: String?, match: String) {
                    if let word = word, !word.isEmpty {
                        jsonData[word] = match
                    }
                }
                
                //Ajouter des checks sur les valeurs nulles etc.
                addToJson(word1Button.text, match: match1Button.text ?? "")
                addToJson(word2Button.text, match: match2Button.text ?? "")
                addToJson(word3Button.text, match: match3Button.text ?? "")
                addToJson(word4Button.text, match: match4Button.text ?? "")
                addToJson(word5Button.text, match: match5Button.text ?? "")
                addToJson(word6Button.text, match: match6Button.text ?? "")
                addToJson(word7Button.text, match: match7Button.text ?? "")
                addToJson(word8Button.text, match: match8Button.text ?? "")
                
                firebaseCollection.document(documentName).setData(jsonData) { error in
                    if let error = error {
                        print("Error")
                        showPopup(title: "An error has occured...", message: "Failed to save your list : \(error.localizedDescription)")
                    } else {
                        showPopup(title: "Success!", message: "Your list was successfully saved.")
                    }
                    
                }
            }
        }
        func showPopup(title: String, message: String, actionTitle: String = "OK", actionHandler: (() -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: actionTitle, style: .default) {_ in
                actionHandler?()
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
